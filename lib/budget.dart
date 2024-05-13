// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:spendify/Components/add_budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:spendify/budgetlimit.dart';
import 'package:spendify/service/userData.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  void initState() {
    super.initState();
    getBudget();
  }

  List<Map<String, dynamic>> budgetData = [];

  Future<void> getBudget() async {
    final String familyId = await UserDataService.getData();
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    String formattedFirstDayOfMonth =
        '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-01';
    String formattedLastDayOfMonth =
        '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}';
    try {
      QuerySnapshot<Map<String, dynamic>> budgetSnapshot =
          await FirebaseFirestore.instance
              .collection('budget')
              .where('family', isEqualTo: familyId)
              .get();
      List<Map<String, dynamic>> data = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> budgetDocSnapshot
          in budgetSnapshot.docs) {
        double totalExp = 0;

        Map<String, dynamic> budget = budgetDocSnapshot.data();
        String catId = budget['category_id'];
        budget['id'] = budgetDocSnapshot.id;
        DocumentSnapshot<Map<String, dynamic>> catSnap = await FirebaseFirestore
            .instance
            .collection('categories')
            .doc(catId)
            .get();
        if (catSnap.exists) {
          Map<String, dynamic>? catdata = catSnap.data();
          if (catdata != null) {
            budget['category'] = catdata['name'];
            budget['icon'] = catdata['icon'];
          }
        }
        QuerySnapshot<Map<String, dynamic>> dailyDocsnap =
            await FirebaseFirestore.instance
                .collection('daily')
                .where('family', isEqualTo: familyId)
                .where('date', isGreaterThanOrEqualTo: formattedFirstDayOfMonth)
                .where('date', isLessThanOrEqualTo: formattedLastDayOfMonth)
                .where('category_id', isEqualTo: catId)
                .get();
        for (QueryDocumentSnapshot<Map<String, dynamic>> dailySnapshot
            in dailyDocsnap.docs) {
          Map<String, dynamic> daily = dailySnapshot.data();
          totalExp += double.parse(daily['amount']);
          budget['date'] = daily['date'];
          budget['time'] = daily['time'];
        }
        double val = totalExp / double.parse(budget['budget']);
        if (val > 1) {
          double temp = 1;
          budget['value'] = temp;
        } else {
          budget['value'] = val;
        }
        budget['expense'] = totalExp.toString();
        data.add(budget);
      }
      setState(() {
        budgetData = data;
      });
    } catch (e) {
      print("Error getting budget: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getBudget();
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          ListView.builder(
            itemCount: budgetData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final budgetDoc = budgetData[index];
              final String budget = budgetDoc['budget'] ?? '';
              final String category = budgetDoc['category'] ?? '';
              final int icon = budgetDoc['icon'] ?? 0;
              final double value = budgetDoc['value'];
              final String expense = budgetDoc['expense'].toString();
              final String id = budgetDoc['id'] ?? '';
              final String date = budgetDoc['date'] ?? '';
              final String time = budgetDoc['time'] ?? '';
              return Budgetlimt(
                  date: date,
                  time: time,
                  exp: expense,
                  budget: budget,
                  id: id,
                  category: category,
                  icon: icon,
                  value: value);
            },
          ),
          const Divider(),
          FutureBuilder<String>(
            future: UserDataService.getData(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text('Error fetching user ID: ${snapshot.error}');
              } else {
                final String userId = snapshot.data!;
                return _buildStreamBuilder(userId);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(String familyId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('categories')
          .where('family', isEqualTo: familyId)
          .where('type', isEqualTo: 'expense')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(28.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Text('No expenses found');
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var category =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;

            final docId = snapshot.data!.docs[index].id;
            final int iconName = category['icon'];
            final random = Random();
            final randomColor = Color.fromARGB(
              255,
              (random.nextInt(64) + 192),
              (random.nextInt(64) + 192),
              (random.nextInt(64) + 192),
            );
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: randomColor,
                child: _buildIcon(iconName),
              ),
              title: Text(
                category['name'] ?? 'Unnamed',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddBudget(
                        docId: docId,
                        category: category['name'],
                        icon: iconName,
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Text("Set Budget"),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIcon(int iconName) {
    return Text(
      String.fromCharCode(iconName),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'MaterialIcons',
      ),
    );
  }
}
