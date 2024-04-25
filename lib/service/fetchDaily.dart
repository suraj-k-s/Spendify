import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  static Future<Map<String, double>> fetchDataFromFirestore(DateTime selectedDate) async {
    Map<String, double> dataMap = {};
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    int year = selectedDate.year.toInt();
    int month = selectedDate.month.toInt();
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1);
    final String startDateString = dateFormat.format(startDate);
    final String endDateString =
        dateFormat.format(endDate.add(const Duration(days: 1)));
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot dailySnapshot = await firestore
          .collection('daily')
          .where('user_id', isEqualTo: user.uid)
          .where('date', isGreaterThanOrEqualTo: startDateString)
          .where('date', isLessThan: endDateString)
          .get();
      for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
        String categoryId = dailyDoc['category_id'];
        double amount = double.parse(dailyDoc['amount']);

        // Retrieve category information from the "categories" collection
        DocumentSnapshot categorySnapshot =
            await firestore.collection('categories').doc(categoryId).get();

        // Check if the category document exists and if it is an expense category
        if (categorySnapshot.exists && categorySnapshot['type'] == 'expense') {
          String categoryName = categorySnapshot['name'];
          if (!dataMap.containsKey(categoryName)) {
            dataMap[categoryName] = amount;
          } else {
            dataMap[categoryName] = dataMap[categoryName]! + amount;
          }
        }
      }
    }
    return dataMap;
  }
}