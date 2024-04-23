import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendify/Components/add_budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:spendify/budgetlimit.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    return ListView(
      shrinkWrap: true,
      children: [
        const Text('Budget'),
        // Budgetlimt(),
        // Divider(),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('categories')
              .where('userId', isEqualTo: userId)
              .where('type', isEqualTo: 'expense')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(28.0),
                child: Center(child: CircularProgressIndicator()),
              ); // Loading indicator
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
                        (random.nextInt(64) + 192), // Red value between 192 and 255
                        (random.nextInt(64) +
                            192), // Green value between 192 and 255
                        (random.nextInt(64) +
                            192), // Blue value between 192 and 255
                      );
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: randomColor, // Provide a default color if color is null
                    child: Icon(
                      IconData(iconName, fontFamily: 'MaterialIcons'),
                      size: 24,
                    ),
                  ),
                  title: Text(
                    category['name'] ??
                        'Unnamed', // Provide a default name if name is null
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddBudget(docId: docId, category: category['name'], icon: iconName,); // Using the MyDialog widget
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
        ),
      ],
    );
  }
}
