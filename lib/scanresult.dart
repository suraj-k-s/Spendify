// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendify/registration_screen.dart';

class QRResult extends StatefulWidget {
  final Map<String, dynamic> qrData;
  const QRResult({super.key, required this.qrData});

  @override
  State<QRResult> createState() => _QRResultState();
}

class _QRResultState extends State<QRResult> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  bool attendanceRegistered = false;
  String userId = '';
  String userName = '';
  bool isLoading = true; 
  bool parent = false; 

  @override
  void initState() {
    super.initState();
    setState(() {
      userId = widget.qrData['id'];
      if(widget.qrData['type']=='PARENT'){
        parent = true;
      }
      fetchUserName(userId);
    });
  }

  Future<void> fetchUserName(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        setState(() {
          userName = data!['name'];
          isLoading = false; // Set loading flag to false after data is fetched
        });
      }
    } catch (e) {
      print("ERROR FETCHING USER DATA: $e");
      setState(() {
        isLoading = false; // Set loading flag to false in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Data'),
      ),
      body: Center(
        child: isLoading
            ? const SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  children: [CircularProgressIndicator(), Text("Loading")],
                ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Parent Name: $userName'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(
                              parent: parent,
                              refId: userId,
                            ),
                          ));
                    },
                    child: parent ? const Text('Register as Parent') : const Text('Register as Child'),
                  ),
                ],
              ),
      ),
    );
  }
}
