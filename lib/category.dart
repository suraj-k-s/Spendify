import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'package:spendify/Components/add_category.dart';
import 'package:spendify/service/userData.dart';

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

        return FutureBuilder(
            future: UserDataService.getData(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return Text(
                    'Error: ${snapshot.error}'); // Handle error if unable to fetch user ID
              }

              final String familyId = snapshot.data!;
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection('categories')
                    .where('family', isEqualTo: familyId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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
                  final List<Map<String, dynamic>> goalCategories = [];

                  for (var doc in snapshot.data!.docs) {
                    final Map<String, dynamic> data = doc.data();
                    final category = {
                      'id': doc.id,
                      'name': data['name'],
                      'icon': data['icon'],
                      'type': data['type'],
                    };

                    if (data['type'] == 'income') {
                      incomeCategories.add(category);
                    } else if (data['type'] == 'expense') {
                      expenseCategories.add(category);
                    } else {
                      goalCategories.add(category);
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
                                child: _buildIcon(category['icon']),
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
                                            id: category['id'],
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
                                child: _buildIcon(category['icon']),
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
                                            id: category['id'],
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
                        const Text(
                          "Goal Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 98, 22, 113),
                              fontSize: 20),
                        ),
                        const Divider(),
                        ListView.builder(
                          itemCount: goalCategories.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final category = goalCategories[index];
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
                                child: _buildIcon(category['icon']),
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
                                            id: category['id'],
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
            });
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
