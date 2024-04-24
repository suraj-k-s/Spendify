import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'package:spendify/Components/add_category.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> deleteItem(String id) async {
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(id)
            .delete();
        Fluttertoast.showToast(
          msg: "Data deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        print("Error deleting document: $error");
        // Show toast notification if there's an error
        Fluttertoast.showToast(
          msg: "Error deleting data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }

    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any other loading indicator
        }

        if (!userSnapshot.hasData || userSnapshot.data == null) {
          return const Text(
              'User not authenticated'); // or any other authentication logic
        }

        final userId = userSnapshot.data!.uid;

        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('categories')
              .where('userId', isEqualTo: userId)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // or any other loading indicator
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // handle error
            }

            final List<Map<String, dynamic>> incomeCategories = [];
            final List<Map<String, dynamic>> expenseCategories = [];

            for (var doc in snapshot.data!.docs) {
              final Map<String, dynamic> data = doc.data();
              final category = {
                'id': doc.id,
                'name': data['name'],
                'icon':
                    IconData(data['icon'] ?? 0, fontFamily: 'MaterialIcons'),
                'type': data['type'],
              };

              if (data['type'] == 'income') {
                incomeCategories.add(category);
              } else {
                expenseCategories.add(category);
              }
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Income Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            255,
                            98,
                            22,
                            113,
                          ),
                          fontSize: 20)),
                  const Divider(),
                  ListView.builder(
                    itemCount: incomeCategories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = incomeCategories[index];
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
                          child: Icon(category['icon']),
                        ),
                        title: Text(
                          category['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDialog(
                                      title: "Edit",
                                      category: category['name'],
                                      icon: category['icon'],
                                    ),
                                  ));
                            } else if (value == 'delete') {
                              deleteItem(category['id']);
                            }
                          },
                        ),
                      );
                    },
                  ),
                  const Text(
                    "Expense Category",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 98, 22, 113),
                        fontSize: 20),
                  ),
                  const Divider(),
                  ListView.builder(
                    itemCount: expenseCategories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = expenseCategories[index];
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
                          child: Icon(category['icon']),
                        ),
                        title: Text(
                          category['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDialog(
                                      title: "Edit",
                                      category: category['name'],
                                      icon: category['icon'],
                                      type: category['type'],
                                    ),
                                  ));
                            } else if (value == 'delete') {
                              deleteItem(category['id']);
                            }
                          },
                        ),
                      );
                    },
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CategoryDialog(
                              title: "Add",
                            ); // Using the MyDialog widget
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(border: Border.all()),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_circle_outline_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ADD NEW CATEGORY',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
