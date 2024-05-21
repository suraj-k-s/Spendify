// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildDataService {
  static Future<String> getData() async {
    try {
      String familyId = '';
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      DocumentSnapshot<Map<String, dynamic>> userSnap = await FirebaseFirestore
          .instance
          .collection('child')
          .doc(userId)
          .get();
      if (userSnap.exists) {
        Map<String, dynamic>? userData = userSnap.data();
        if (userData != null) {
          familyId = userData['family'];
        }
        return familyId; // Return parentId when fetched
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
