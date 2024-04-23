import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendify/Components/filtersheet.dart';
import 'package:spendify/Components/popupdaily.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  double totalAmt = 0.0;
  double totalExpenses = 0.0;
  double totalIncome = 0.0;
  DateTime? _previousDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  List<Map<String, dynamic>> dailyData = [];

  @override
  void initState() {
    super.initState();
    getDaily();
  }

  void _changeMonth(int increment) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + increment);
    });
    getDaily();
  }

  Future<void> getDaily() async {
    try {
      double total = 0;
      double exp = 0;
      double inc = 0;
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      int year = _selectedDate.year.toInt();
      int month = _selectedDate.month.toInt();
      final startDate = DateTime(year, month, 1);
      final endDate = DateTime(year, month + 1, 1);
      final String startDateString = dateFormat.format(startDate);
      final String endDateString =
          dateFormat.format(endDate.add(const Duration(days: 1)));
      List<Map<String, dynamic>> daily = [];
      QuerySnapshot<Map<String, dynamic>> totalSnapshot =
          await FirebaseFirestore.instance
              .collection('daily')
              .where('user_id', isEqualTo: userId)
              .where('date', isGreaterThanOrEqualTo: startDateString)
              .where('date', isLessThan: endDateString)
              .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        print(data);
        double amt = double.parse(data['amount']);
        data['id'] = documentSnapshot.id;
        DocumentSnapshot<Map<String, dynamic>> catSnap = await FirebaseFirestore
            .instance
            .collection('categories')
            .doc(data['category_id'])
            .get();
        if (catSnap.exists) {
          Map<String, dynamic>? catdata = catSnap.data();
          if (catdata != null) {
            print("CategorY: ${catdata['name']}");
            print("icon: ${catdata['icon']}");
            print("type: ${catdata['type']}");
            data['category'] = catdata['name'];
            data['icon'] = catdata['icon'];
            data['type'] = catdata['type'];
          }

          if (catdata?['type'] == 'income') {
            inc += amt;
          } else {
            exp += amt;
          }
        }
        daily.add(data);
      }
      print(daily);
      setState(() {
        dailyData = daily;
      });
      total = inc - exp;
      setState(() {
        totalAmt = total;
        totalExpenses = exp;
        totalIncome = inc;
      });
    } catch (e) {
      print("Error Daily: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {
                      _changeMonth(-1); // Move to previous month
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color.fromARGB(255, 48, 2, 35),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat.yMMMM().format(_selectedDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _changeMonth(1); // Move to next month
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Color.fromARGB(255, 48, 2, 35),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const FilterSheet(),
                      );
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      color: Color.fromARGB(255, 48, 2, 35),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "EXPENSE",
                    style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                  ),
                  Text(
                    totalExpenses.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "INCOME",
                    style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                  ),
                  Text(
                    totalIncome.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "TOTAL",
                    style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                  ),
                  Text(
                    totalAmt.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dailyData.length,
            itemBuilder: (context, index) {
              final daily = dailyData[index];
              String amount = '0';
              final String note = daily['note'] ?? '';
              final timeString = daily['time'] ?? '';
              final formattedTimeString = '$timeString:00';
              final time = DateFormat('HH:mm:ss').parse(formattedTimeString);
              final DateTime date = DateTime.parse(daily['date']);
              final String bill = daily['bill'] ?? '';
              // final String id = documents[index].id;
              final int iconName = daily['icon'] ?? 0;
              final String type = daily['type'] ?? '';
              final String category = daily['category'] ?? '';
              final String id = daily['id'] ?? '';
              Color amountColor = type == 'expense' ? Colors.red : Colors.green;
              if( type == 'expense' ){
                amount = "-${daily['amount']}";
              }
              else{
                amount = daily['amount'];
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_previousDate != null)
                    Text(
                      DateFormat('MMMM dd, EEEE').format(date),
                      style: const TextStyle(fontSize: 15),
                    ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PopupDaily(
                                amt: amount,
                                date: date,
                                note: note,
                                id: id,
                                time: time,
                                type: type,
                                icon: iconName,
                                category: category,
                                bill: bill,
                              ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: _buildIcon(
                          iconName), // Using a helper function to build the icon
                    ),
                    title: Text(category,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                      amount,
                      style: TextStyle(fontSize: 18, color: amountColor),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  // Helper function to build the icon based on iconName
  Widget _buildIcon(int iconName) {
    return Text(
      String.fromCharCode(iconName), // Convert iconName to Unicode character
      style: const TextStyle(
        fontSize: 24, // Adjust font size as needed
        fontFamily:
            'MaterialIcons', // Ensure the correct font family is used (Material Icons)
      ),
    );
  }
}
