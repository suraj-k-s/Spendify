import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendify/Components/filtersheet.dart';
import 'package:spendify/calendar.dart';
import 'package:spendify/chart.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  DateTime _selectedDate = DateTime.now();
  void _changeMonth(int increment) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + increment);
    });
  }

  final List<Widget> _pages = [Calendar(), Chart()];
  int _currentIndex = 0;
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "EXPENSE",
                  style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                ),
                Text(
                  "5000",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(
                  "INCOME",
                  style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                ),
                Text(
                  "6000",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "TOTAL",
                  style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                ),
                Text(
                  "11000",
                  style: TextStyle(color: Colors.black),
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
                child: Text('Calendar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('Chart'),
              ),
            ],
            onChanged: (newIndex) {
              setState(() {
                _currentIndex = newIndex!;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _pages[_currentIndex],
      ],
    );
  }
}
