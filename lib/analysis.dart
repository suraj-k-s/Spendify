import 'package:flutter/material.dart';
import 'package:spendify/Components/filtersheet.dart';
import 'package:spendify/calendar.dart';
import 'package:spendify/chart.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final List<Widget> _pages = [Calendar(), Chart()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(255, 48, 2, 35),
                  )),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "May,2024",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 48, 2, 35),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      )),
                ],
              )
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText:'Overview',
                border: OutlineInputBorder()
              ),
              value: _currentIndex,
              hint: Text('Overview'),
              items: [
                DropdownMenuItem(
                  child: Text('Calendar',style: TextStyle(fontWeight: FontWeight.bold,)),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text('Chart'),
                  value: 1,
                ),
              ],
              onChanged: (newIndex) {
                setState(() {
                  _currentIndex = newIndex!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _pages[_currentIndex],
        ],
      ),
    );
  }
}