// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendify/service/parentdata.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class ChildCalendar extends StatefulWidget {
  const ChildCalendar({super.key});

  @override
  _ChildCalendarState createState() => _ChildCalendarState();
}

class _ChildCalendarState extends State<ChildCalendar> {
  final List<Appointment> _appointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: _getCalendarDataSource(),
          onTap: (CalendarTapDetails details) {
            _showAddTransactionDialog(context, details.date);
          },
        ),
      ),
    );
  }

  _showAddTransactionDialog(BuildContext context, DateTime? date) async {
  if (date != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Flag to track if data is being fetched
        bool isLoading = true;

        // Start fetching data
        fetchData() async {
          final String userId = await DataService.getData();
          QuerySnapshot dailySnapshot = await FirebaseFirestore.instance
              .collection('daily')
              .where('user_id', isEqualTo: userId)
              .where('date', isEqualTo: formattedDate)
              .get();

          Map<String, double> dataExp = {};
          Map<String, double> dataInc = {};
          double inc = 0;
          double exp = 0;
          double total = 0;

          for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
            String categoryId = dailyDoc['category_id'];
            double amount = double.parse(dailyDoc['amount']);

            DocumentSnapshot categorySnapshot =
                await FirebaseFirestore.instance.collection('categories').doc(categoryId).get();

            if (categorySnapshot.exists && categorySnapshot['type'] == 'expense') {
              String categoryName = categorySnapshot['name'];
              if (!dataExp.containsKey(categoryName)) {
                dataExp[categoryName] = amount;
              } else {
                dataExp[categoryName] = dataExp[categoryName]! + amount;
              }
            }
            if (categorySnapshot.exists && categorySnapshot['type'] == 'income') {
              String categoryName = categorySnapshot['name'];
              if (!dataInc.containsKey(categoryName)) {
                dataInc[categoryName] = amount;
              } else {
                dataInc[categoryName] = dataInc[categoryName]! + amount;
              }
            }
            if (categorySnapshot['type'] == 'income') {
              inc += amount;
            } else if (categorySnapshot['type'] == 'expense'){
              exp += amount;
            }
          }
          total = inc - exp;

          // Set loading to false once data fetching is complete
          isLoading = false;

          // Rebuild the dialog to reflect the fetched data
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Today's Transactions"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Date: $formattedDate'),
                    // Display your fetched data here
                    // For example:
                    Text('Total Income: $inc'),
                    Text('Total Expense: $exp'),
                    Text('Net Total: $total'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Save transaction logic goes here
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        }

        // Start fetching data when the dialog is built
        fetchData();

        return WillPopScope(
          onWillPop: () async => !isLoading,
          child: AlertDialog(
            title: isLoading ? const Text("Loading...") : const Text("Today's Transactions"),
            content: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  } else {
    // Handle null date if needed
    print('Date is null');
  }
}


  _DataSource _getCalendarDataSource() {
    return _DataSource(_appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
