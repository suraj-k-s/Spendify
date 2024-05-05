import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:spendify/calendar.dart';
import 'package:spendify/chart_expense.dart';
import 'package:spendify/chart_income.dart';
import 'package:spendify/service/parentdata.dart';

class ChildAnalysis extends StatefulWidget {
  const ChildAnalysis({super.key});

  @override
  State<ChildAnalysis> createState() => _ChildAnalysisState();
}

class _ChildAnalysisState extends State<ChildAnalysis> {
  Map<String, double> dataExp = {};
  Map<String, double> dataInc = {};
  DateTime _selectedDate = DateTime.now();
  double totalAmt = 0.0;
  double totalExpenses = 0.0;
  double totalIncome = 0.0;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  void _changeMonth(int increment) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + increment);
    });
    getDaily();
  }

  bool dataLoaded = false;

  Future<void> getDaily() async {
    double total = 0;
    double exp = 0;
    double inc = 0;
    int year = _selectedDate.year.toInt();
    int month = _selectedDate.month.toInt();
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1);
    final String startDateString = dateFormat.format(startDate);
    final String endDateString =
        dateFormat.format(endDate.add(const Duration(days: 1)));
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = await DataService.getData();
    QuerySnapshot dailySnapshot = await firestore
        .collection('daily')
        .where('user_id', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: startDateString)
        .where('date', isLessThan: endDateString)
        .get();
    dataExp.clear();
    dataInc.clear();
    for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
      String categoryId = dailyDoc['category_id'];
      double amount = double.parse(dailyDoc['amount']);

      DocumentSnapshot categorySnapshot =
          await firestore.collection('categories').doc(categoryId).get();

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
      } else if (categorySnapshot['type'] == 'expense') {
        exp += amount;
      }
    }
    total = inc - exp;
    setState(() {
      totalAmt = total;
      totalExpenses = exp;
      totalIncome = inc;
      dataLoaded = true;
    });
  }

  Future<void> getWeekly() async {
    double total = 0;
    double exp = 0;
    double inc = 0;
    DateTime selectedStartOfWeek =
          _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
      DateTime selectedEndOfWeek = selectedStartOfWeek.add(Duration(days: 6));
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = await DataService.getData();
    QuerySnapshot dailySnapshot = await firestore
        .collection('daily')
        .where('user_id', isEqualTo: userId)
        .where('date',
                  isGreaterThanOrEqualTo: selectedStartOfWeek.toString())
              .where('date', isLessThanOrEqualTo: selectedEndOfWeek.toString())
        .get();
    dataExp.clear();
    dataInc.clear();
    for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
      String categoryId = dailyDoc['category_id'];
      double amount = double.parse(dailyDoc['amount']);

      DocumentSnapshot categorySnapshot =
          await firestore.collection('categories').doc(categoryId).get();

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
      } else if (categorySnapshot['type'] == 'expense') {
        exp += amount;
      }
    }
    total = inc - exp;
    setState(() {
      totalAmt = total;
      totalExpenses = exp;
      totalIncome = inc;
      dataLoaded = true;
    });
  }

Future<void> getDay() async {
    double total = 0;
    double exp = 0;
    double inc = 0;
    final String selectedDateString =
          DateFormat('yyyy-MM-dd').format(_selectedDate);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = await DataService.getData();
    QuerySnapshot dailySnapshot = await firestore
        .collection('daily')
        .where('user_id', isEqualTo: userId)
        .where('date', isEqualTo: selectedDateString)
        .get();
    dataExp.clear();
    dataInc.clear();
    for (QueryDocumentSnapshot dailyDoc in dailySnapshot.docs) {
      String categoryId = dailyDoc['category_id'];
      double amount = double.parse(dailyDoc['amount']);

      DocumentSnapshot categorySnapshot =
          await firestore.collection('categories').doc(categoryId).get();

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
      } else if (categorySnapshot['type'] == 'expense') {
        exp += amount;
      }
    }
    total = inc - exp;
    setState(() {
      totalAmt = total;
      totalExpenses = exp;
      totalIncome = inc;
      dataLoaded = true;
    });
  }

  late List<Widget> _pages;

  void updateSelectedDate(DateTime newDate, Function callback) {
    setState(() {
      _selectedDate = newDate;
    });
    callback();
  }

  @override
  void initState() {
    _pages = [
      const SelectOption(),
      ChartE(data: dataExp),
      ChartI(
        data: dataInc,
      ),
    ];
    super.initState();
    getDaily();
  }

   String _filterSelection = 'monthly'; // Default filter selection

  void _setFilter(String filter) {
    setState(() {
      _filterSelection = filter;
    });
    getDaily();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getDaily();
      },
      child: SingleChildScrollView(
        child: Column(
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
                                _selectedDate =
                                    _selectedDate.subtract(Duration(days: 1));
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
                                    _selectedDate.add(Duration(days: 1));
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
                                DateFormat.yMMMMd().format(_selectedDate.add(Duration(days: 7 - _selectedDate.weekday))),
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
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    hintText: 'Overview', border: OutlineInputBorder()),
                value: _currentIndex,
                hint: const Text('Overview'),
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('Select an Option',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Chart Expense'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Chart Income'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('Calendar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
                onChanged: (newIndex) {
                  if (newIndex == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyCalendar(),
                        ));
                  } else {
                    setState(() {
                      _currentIndex = newIndex!;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _pages[_currentIndex],
          ],
        ),
      ),
    );
  }

  final colorList = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.orangeAccent,
  ];
  Widget chartExp() {
    return Column(
      children: [
        if (dataLoaded)
          dataExp.isNotEmpty
              ? PieChart(
                  dataMap: dataExp,
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
    );
  }
}

class SelectOption extends StatelessWidget {
  const SelectOption({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Select an Option'),
    );
  }
}

class FilterSheet extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterSelected;

  const FilterSheet({
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