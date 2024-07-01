// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendify/data/iconData.dart';

class CategoryDialog extends StatefulWidget {
  final String title;
  final String type;
  final String category;
  final IconData? icon;
  final String? id;

  const CategoryDialog({
    super.key,
    required this.title,
    this.type = 'income',
    this.category = '',
    this.icon,
    this.id = '',
  });

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  String? _type;
  IconData? _selectedIcon;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    _selectedIcon = widget.icon; // Set the initially selected icon
    _textEditingController.text = widget.category;
  }

  void addCategory() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      String categoryName = _textEditingController.text;
      int? iconCodePoint = _selectedIcon?.codePoint;
      _firestore.collection('categories').add({
        'type': _type,
        'icon': iconCodePoint,
        'name': categoryName,
        'family': userId,
      });
      Navigator.of(context).pop();
    } catch (e) {
      print("Error inserting: $e");
    }
  }

  Future<void> editCategory() async {
    try {
      Map<String, dynamic> updateData = {
        'type': _type,
        'name': _textEditingController.text,
      };

      if (_selectedIcon != null) {
        updateData['icon'] = _selectedIcon?.codePoint;
      }

      await _firestore
          .collection('categories')
          .doc(widget.id)
          .update(updateData);
      Navigator.of(context).pop();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('${widget.title} Category'),
        content: SizedBox(
          height: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Type:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _type = "income";
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        if (_type == 'income')
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(Icons.check),
                          ),
                        Text(
                          'INCOME',
                          style: TextStyle(
                            letterSpacing: .7,
                            fontSize: 16,
                            color: _type != 'income'
                                ? const Color.fromARGB(255, 135, 135, 135)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _type = "expense";
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        if (_type == 'expense')
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(Icons.check),
                          ),
                        Text(
                          'EXPENSE',
                          style: TextStyle(
                            letterSpacing: .7,
                            fontSize: 16,
                            color: _type != 'expense'
                                ? const Color.fromARGB(255, 135, 135, 135)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _type = "goals";
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        if (_type == 'goals')
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(Icons.check),
                          ),
                        Text(
                          'GOAL',
                          style: TextStyle(
                            letterSpacing: .7,
                            fontSize: 16,
                            color: _type != 'goals'
                                ? const Color.fromARGB(255, 135, 135, 135)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter category name',
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Icons:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                height: 100,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: iconsList.length,
                  itemBuilder: (context, index) {
                    final random = Random();
                    final randomColor = Color.fromARGB(
                      255,
                      random.nextInt(64) + 192, // Red value between 192 and 255
                      random.nextInt(64) +
                          192, // Green value between 192 and 255
                      random.nextInt(64) +
                          192, // Blue value between 192 and 255
                    );
                    Color iconColor = _selectedIcon == iconsList[index]
                        ? Colors.blue
                        : Colors.black;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = iconsList[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                          color: randomColor,
                        ),
                        child: Icon(
                          iconsList[index],
                          color: iconColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (widget.id == "") {
                addCategory();
              } else {
                editCategory();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
