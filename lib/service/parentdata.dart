// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  static Future<String> getData() async {
    try {
      String parentId = '';
      final user = FirebaseAuth.instance.currentUser;
      final childId = user?.uid;
      DocumentSnapshot<Map<String, dynamic>> childSnap = await FirebaseFirestore
          .instance
          .collection('child')
          .doc(childId)
          .get();
      if (childSnap.exists) {
        Map<String, dynamic>? childData = childSnap.data();
        if (childData != null) {
          parentId = childData['parent_id'];
        }
        return parentId; // Return parentId when fetched
      } else {
        // Handle case where document doesn't exist
        print("Document does not exist.");
        return ''; // or throw an exception
      }
    } catch (e) {
      print("Error: $e ");
      return ''; // or throw an exception
    }
  }
}
