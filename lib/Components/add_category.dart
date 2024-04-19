import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendify/data/iconData.dart';

class CategoryDialog extends StatefulWidget {
  final String title;
  const CategoryDialog({Key? key, required this.title}) : super(key: key);

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isIncomeSelected = true;
  bool _isExpenseSelected = false;
  String _type = "income";
  IconData? _selectedIcon;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void addcategory() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      String categoryName = _textEditingController.text;
      int? iconCodePoint = _selectedIcon?.codePoint;
      _firestore.collection('categories').add({
        'type': _type,
        'icon': iconCodePoint,
        'name': categoryName,
        'userId': userId
      });

      Navigator.of(context).pop();
    } catch (e) {
      print("Error inserting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.title} Category'),
      content: Column(
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
                  print('Income');
                  setState(() {
                    _isIncomeSelected = true;
                    _isExpenseSelected = false;
                    _type = "income";
                  });
                },
                child: Row(
                  children: <Widget>[
                    if (_isIncomeSelected)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check),
                      ),
                    Text(
                      'INCOME',
                      style: TextStyle(
                          letterSpacing: .7,
                          fontSize: 16,
                          color: _isExpenseSelected
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
                  print('Expense');
                  setState(() {
                    _isIncomeSelected = false;
                    _isExpenseSelected = true;
                    _type = "expense";
                  });
                },
                child: Row(
                  children: <Widget>[
                    if (_isExpenseSelected)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check),
                      ),
                    Text(
                      'EXPENSE',
                      style: TextStyle(
                          letterSpacing: .7,
                          fontSize: 16,
                          color: _isIncomeSelected
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
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemCount: iconsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = iconsList[index];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all()),
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
      actions: <Widget>[
        TextButton(
          onPressed: () {
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
