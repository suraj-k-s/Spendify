import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChartI extends StatefulWidget {
  const ChartI({super.key});

  @override
  State<ChartI> createState() => _ChartState();
}

class _ChartState extends State<ChartI> {
  Map<String, double> dataMap = {};
  final colorList = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.orangeAccent,
  ];
  bool dataLoaded = false;

  Future<void> fetchDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot dailySnapshot = await firestore
          .collection('daily')
          .where('user_id', isEqualTo: user.uid)
          .get();
      dataMap.clear();
      for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
        String categoryId = dailyDoc['category_id'];
        double amount = double.parse(dailyDoc['amount']);

        // Retrieve category information from the "categories" collection
        DocumentSnapshot categorySnapshot =
            await firestore.collection('categories').doc(categoryId).get();

        // Check if the category document exists and if it is an expense category
        if (categorySnapshot.exists && categorySnapshot['type'] == 'income') {
          String categoryName = categorySnapshot['name'];
          if (!dataMap.containsKey(categoryName)) {
            dataMap[categoryName] = amount;
          } else {
            dataMap[categoryName] = dataMap[categoryName]! + amount;
          }
        }
      }
      setState(() {
        dataLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (dataLoaded)
            dataMap.isNotEmpty
                ? PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width != 0
                        ? MediaQuery.of(context).size.width / 3.2
                        : 0,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "Expense",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  )
                : const Text('No data found'),
        ],
      ),
    );
  }
}
