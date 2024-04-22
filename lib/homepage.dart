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
  late Stream<QuerySnapshot> _dailyDataStream;
  DateTime? _previousDate;

  @override
  void initState() {
    super.initState();
    _initDailyDataStream();
    getTotal();
  }

  void _initDailyDataStream() {
    _dailyDataStream = getDailyDataStream();
  }

  void _changeMonth(int increment) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + increment);
      _initDailyDataStream();
      getTotal();
    });
  }

  Future<void> getTotal() async {
    int year = _selectedDate.year.toInt();
    int month = _selectedDate.month.toInt();
    double total = 0;
    double exp = 0;
    double inc = 0;
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1);
    try {
      QuerySnapshot<Map<String, dynamic>> totalSnapshot =
          await FirebaseFirestore.instance
              .collection('daily')
              .where('user_id', isEqualTo: userId)
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThan: endDate)
              .get();

      // Process the data in totalSnapshot
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        // Access data from each document
        Map<String, dynamic> data = documentSnapshot.data();
        double amt = double.parse(data['amount']);
        DocumentSnapshot<Map<String, dynamic>> catSnap = await FirebaseFirestore
            .instance
            .collection('categories')
            .doc(data['category_id'])
            .get();
        if (catSnap.exists) {
          Map<String, dynamic>? catdata = catSnap.data();
          if (catdata?['type'] == 'income') {
            inc += amt;
          } else {
            exp += amt;
          }
        }
      }
      total = inc - exp;
      setState(() {
        totalAmt = total;
        totalExpenses = exp;
        totalIncome = inc;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Stream<QuerySnapshot> getDailyDataStream() {
    int year = _selectedDate.year.toInt();
    int month = _selectedDate.month.toInt();
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1);

    return FirebaseFirestore.instance
        .collection('daily')
        .where('user_id', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: startDate.toString())
        .where('date', isLessThan: endDate.toString())
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        StreamBuilder<QuerySnapshot>(
          stream: _dailyDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final documents = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                final DateTime date = DateTime.parse(data['date']);
                if (_previousDate != null &&
                    _previousDate!.isAtSameMomentAs(date)) {
                  return const SizedBox.shrink(); // Skip printing date
                }
                _previousDate = date;

                final String amount = data['amount'] ?? '0';
                final String categoryId = data['category_id'];
                final String note = data['note'];
                final timeString = data['time'];
                final formattedTimeString = '$timeString:00';
                final time = DateFormat('HH:mm:ss').parse(formattedTimeString);
                final String bill = data['bill'] ?? '';
                final String id = documents[index].id;

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('categories')
                      .doc(categoryId)
                      .get(),
                  builder: (context, categorySnapshot) {
                    if (categorySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (categorySnapshot.hasError) {
                      return Text('Error: ${categorySnapshot.error}');
                    }

                    final categoryData =
                        categorySnapshot.data!.data() as Map<String, dynamic>;
                    final int iconName = categoryData['icon'];
                    final String type = categoryData['type'];
                    final String category = categoryData['name'];

                    // Determine the color based on expense or income
                    Color amountColor =
                        type == 'expense' ? Colors.red : Colors.green;

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
                          title: const Text("Expenses",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                            "-$amount",
                            style: TextStyle(fontSize: 18, color: amountColor),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        )
      ],
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
