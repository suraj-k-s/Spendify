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
  const CategoryDialog(
      {Key? key,
      required this.title,
      this.type = 'income',
      this.category = '',
      this.icon,
      this.id})
      : super(key: key);

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
    _selectedIcon = widget.icon;
    _type = widget.type;
    _textEditingController.text = widget.category;
  }

  void addcategory() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      String categoryName = _textEditingController.text;
      int? iconCodePoint = _selectedIcon?.codePoint;
      if (widget.id == null) {
        _firestore.collection('categories').add({
          'type': _type,
          'icon': iconCodePoint,
          'name': categoryName,
          'userId': userId
        });
      } else {
        _firestore.collection('categories').doc(widget.id).update({
          'type': _type,
          'icon': iconCodePoint,
          'name': categoryName,
          'userId': userId
        });
      }

      Navigator.of(context).pop();
    } catch (e) {
      print("Error inserting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.title} Category'),
      content: Container(
        height: 250,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Type:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _type = "income";
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      if (_type == 'income')
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.check),
                        ),
                      Text(
                        'INCOME',
                        style: TextStyle(
                            letterSpacing: .7,
                            fontSize: 16,
                            color: _type != 'income'
                                ? Color.fromARGB(255, 135, 135, 135)
                                : null),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _type = "expense";
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      if (_type == 'expense')
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.check),
                        ),
                      Text(
                        'EXPENSE',
                        style: TextStyle(
                            letterSpacing: .7,
                            fontSize: 16,
                            color: _type != 'expense'
                                ? Color.fromARGB(255, 135, 135, 135)
                                : null),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter category name',
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Icons:',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              height: 100,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
                itemCount: iconsList.length,
                itemBuilder: (context, index) {
                  final random = Random();
                  final randomColor = Color.fromARGB(
                    255,
                    (random.nextInt(64) + 192), // Red value between 192 and 255
                    (random.nextInt(64) +
                        192), // Green value between 192 and 255
                    (random.nextInt(64) +
                        192), // Blue value between 192 and 255
                  );
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
                          color: randomColor),
                      child: Icon(
                        iconsList[index],
                        color: _selectedIcon == iconsList[index]
                            ? Colors.blue
                            : Colors.black,
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
            print("icon: $_selectedIcon");

            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            addcategory();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
