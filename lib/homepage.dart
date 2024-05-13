import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendify/Components/popupdaily.dart';
import 'package:spendify/service/userData.dart';

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

  Future<void> getDaily() async {
    try {
      double total = 0;
      double exp = 0;
      double inc = 0;
      final String familyId = await UserDataService.getData();
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
              .where('family', isEqualTo: familyId)
              .where('date', isGreaterThanOrEqualTo: startDateString)
              .where('date', isLessThan: endDateString)
              .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
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
            data['category'] = catdata['name'];
            data['icon'] = catdata['icon'];
            data['type'] = catdata['type'];
          }

          if (catdata?['type'] == 'income') {
            inc += amt;
          } else if (catdata?['type'] == 'expense') {
            exp += amt;
          }
        }
        if (data['type'] != 'goals') {
          daily.add(data);
        }
      }
      total = inc - exp;
      setState(() {
        dailyData = daily;
        totalAmt = total;
        totalExpenses = exp;
        totalIncome = inc;
      });
    } catch (e) {
      print("Error Daily: $e");
    }
  }

  Future<void> getWeekly() async {
    try {
      double total = 0;
      double exp = 0;
      double inc = 0;
      final String familyId = await UserDataService.getData();
      List<Map<String, dynamic>> weekly = [];

      // Calculate the start and end dates of the selected week
      DateTime selectedStartOfWeek =
          _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
      DateTime selectedEndOfWeek =
          selectedStartOfWeek.add(const Duration(days: 6));

      QuerySnapshot<Map<String, dynamic>> totalSnapshot =
          await FirebaseFirestore.instance
              .collection('daily')
              .where('family', isEqualTo: familyId)
              .where('date',
                  isGreaterThanOrEqualTo: selectedStartOfWeek.toString())
              .where('date', isLessThanOrEqualTo: selectedEndOfWeek.toString())
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
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
            data['category'] = catdata['name'];
            data['icon'] = catdata['icon'];
            data['type'] = catdata['type'];
          }

          if (catdata?['type'] == 'income') {
            inc += amt;
          } else if (catdata?['type'] == 'expense') {
            exp += amt;
          }
        }
        if (data['type'] != 'goals') {
          weekly.add(data);
        }
      }
      total = inc - exp;
      setState(() {
        dailyData = weekly;
        totalAmt = total;
        totalExpenses = exp;
        totalIncome = inc;
      });
    } catch (e) {
      print("Error Weekly: $e");
    }
  }

  Future<void> getDay() async {
    try {
      double total = 0;
      double exp = 0;
      double inc = 0;
      final String familyId = await UserDataService.getData();
      List<Map<String, dynamic>> daily = [];

      // Format the selected date to match the date format in Firestore
      final String selectedDateString =
          DateFormat('yyyy-MM-dd').format(_selectedDate);
      QuerySnapshot<Map<String, dynamic>> totalSnapshot =
          await FirebaseFirestore.instance
              .collection('daily')
              .where('family', isEqualTo: familyId)
              .where('date', isEqualTo: selectedDateString)
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
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
            data['category'] = catdata['name'];
            data['icon'] = catdata['icon'];
            data['type'] = catdata['type'];
          }

          if (catdata?['type'] == 'income') {
            inc += amt;
          } else if (catdata?['type'] == 'expense') {
            exp += amt;
          }
        }
        if (data['type'] != 'goals') {
          daily.add(data);
        }
      }
      total = inc - exp;
      setState(() {
        dailyData = daily;
        totalAmt = total;
        totalExpenses = exp;
        totalIncome = inc;
      });
    } catch (e) {
      print("Error Daily: $e");
    }
  }

  String _filterSelection = 'monthly'; // Default filter selection

  void _setFilter(String filter) {
    setState(() {
      _filterSelection = filter;
    });
    getDaily();
  }

  @override
  Widget build(BuildContext context) {
    return buildMainContent();
  }

  Widget buildMainContent() {
    return RefreshIndicator(
      onRefresh: () async {
        if (_filterSelection == "monthly") {
          await getDaily();
        } else if (_filterSelection == "weekly") {
          await getWeekly();
        } else if (_filterSelection == "daily") {
          await getDay();
        }
      },
      child: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  if (_filterSelection !=
                      'weekly') // Display monthly or daily view
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_filterSelection == 'daily') {
                              setState(() {
                                _selectedDate = _selectedDate
                                    .subtract(const Duration(days: 1));
                              });
                              getDay();
                            } else {
                              setState(() {
                                _selectedDate = DateTime(_selectedDate.year,
                                    _selectedDate.month - 1);
                              });
                              getDaily();
                            }
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Color.fromARGB(255, 48, 2, 35),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _filterSelection == 'daily'
                              ? DateFormat.yMMMMd().format(_selectedDate)
                              : DateFormat.yMMMM().format(_selectedDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            if (_filterSelection == 'daily') {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(const Duration(days: 1));
                              });
                              getDay();
                            } else {
                              setState(() {
                                _selectedDate = DateTime(_selectedDate.year,
                                    _selectedDate.month + 1);
                              });
                              getDaily();
                            }
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 48, 2, 35),
                          ),
                        ),
                      ],
                    ),
                  if (_filterSelection == 'weekly') // Display weekly view
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = _selectedDate
                                  .subtract(const Duration(days: 7));
                            });
                            getWeekly();
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Color.fromARGB(255, 48, 2, 35),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${DateFormat.yMMMMd().format(_selectedDate.subtract(Duration(days: _selectedDate.weekday - 1)))} - ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(_selectedDate.add(
                                    Duration(days: 7 - _selectedDate.weekday))),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate =
                                  _selectedDate.add(const Duration(days: 7));
                            });
                            getWeekly();
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 48, 2, 35),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    // Filter button
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => FilterSheet(
                              currentFilter: _filterSelection,
                              onFilterSelected: _setFilter,
                            ),
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
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dailyData.length,
                itemBuilder: (context, index) {
                  final daily = dailyData[index];
                  String amount = '0';
                  final String note = daily['note'] ?? '';
                  final timeString = daily['time'] ?? '';
                  final formattedTimeString = '$timeString:00';
                  final time =
                      DateFormat('HH:mm:ss').parse(formattedTimeString);
                  final DateTime date = DateTime.parse(daily['date']);
                  final String bill = daily['bill'] ?? '';

                  final int iconName = daily['icon'] ?? 0;
                  final String type = daily['type'] ?? '';
                  final String category = daily['category'] ?? '';
                  final String id = daily['id'] ?? '';
                  Color amountColor =
                      type == 'expense' ? Colors.red : Colors.green;
                  if (type == 'expense') {
                    amount = "-${daily['amount']}";
                  } else {
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
                          child: _buildIcon(iconName),
                        ),
                        title: Text(category,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }

  Widget _buildIcon(int iconName) {
    return Text(
      String.fromCharCode(iconName),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of your animation controllers here
    super.dispose();
  }
}

class FilterSheet extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterSelected;

  const FilterSheet({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Display Options'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text('Weekly'),
              onTap: () {
                onFilterSelected('weekly');
                Navigator.pop(context);
              },
              selected: currentFilter == 'weekly',
            ),
            ListTile(
              title: const Text('Monthly'),
              onTap: () {
                onFilterSelected('monthly');
                Navigator.pop(context);
              },
              selected: currentFilter == 'monthly',
            ),
            ListTile(
              title: const Text('Daily'),
              onTap: () {
                onFilterSelected('daily');
                Navigator.pop(context);
              },
              selected: currentFilter == 'daily',
            ),
          ],
        ),
      ),
    );
  }
}
