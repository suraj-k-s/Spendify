import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBudget extends StatefulWidget {
  final String docId;
  final int icon;
  final String category;
  final String id;
  final String amt;

  const AddBudget(
      {super.key,
      required this.docId,  
      required this.icon,
      required this.category,
      this.id = '',
      this.amt = "0"});

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {

  @override
  void initState(){
    super.initState();
    _limitController.text = widget.amt;
  }
  final TextEditingController _limitController = TextEditingController();

  Future<void> insertBudge() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      await FirebaseFirestore.instance.collection('budget').add(
        {
          'category_id': widget.docId,
          'budget': _limitController.text,
          'user_id': userId,
        },
      );
      Fluttertoast.showToast(
        msg: "Budget Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error Adding Budget: $e');
      Fluttertoast.showToast(
        msg: "Adding budget failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> editBudget() async {
    try {
      await FirebaseFirestore.instance.collection('budget').doc(widget.id).update(
        {
          'budget': _limitController.text,
        },
      );
      Fluttertoast.showToast(
        msg: "Budget Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "Budget Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Budget'),
      content: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconData(widget.icon, fontFamily: 'MaterialIcons'),
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.category,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Flexible(child: Text("Limit")),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: TextFormField(
                  controller: _limitController,
                  decoration: const InputDecoration(
                    hintText: "0",
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if(widget.id == ''){
              insertBudge();
            }
            else{
              editBudget();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
