import 'dart:js_interop';

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
  void insertfeedback() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter the feed back',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Send Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}
