// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this line

  void insertfeedback() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final userId = user?.uid; //storing uid of user to userId
        String feedback = _textEditingController.text;
        _firestore
            .collection('feedback')
            .add({'userId': userId, 'feedback': feedback});
        Fluttertoast.showToast(
          msg: "Thank You ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(
          msg: " Please try again ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        print("Error inserting: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form( // Wrap your form with Form widget
          key: _formKey, // Assign the key
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter the feedback',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Feedback cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      insertfeedback();
                    },
                    child: const Text("Send Feedback"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

