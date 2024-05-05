// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spendify/budgetlimit.dart';
import 'package:spendify/service/parentdata.dart';

class ChildBudget extends StatefulWidget {
  const ChildBudget({super.key});

  @override
  State<ChildBudget> createState() => _ChildBudgetState();
}

class _ChildBudgetState extends State<ChildBudget> {
  @override
  void initState() {
    super.initState();
    getBudget();
  }

  List<Map<String, dynamic>> budgetData = [];

  Future<void> getBudget() async {
    final userId = await DataService.getData();
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
              .where('user_id', isEqualTo: userId)
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
                .where('user_id', isEqualTo: userId)
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
                  value: value,
                  edit: false);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
