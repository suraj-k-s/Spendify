// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendify/about.dart';
import 'package:spendify/blog.dart';
import 'package:spendify/child/analysis.dart';
import 'package:spendify/child/budget.dart';
import 'package:spendify/child/calculator.dart';
import 'package:spendify/child/homepage.dart';
import 'package:spendify/feedback.dart';
import 'package:spendify/help.dart';
import 'package:spendify/login_screen.dart';
import 'package:spendify/view_profile.dart';

class ChildDashBoard extends StatefulWidget {
  const ChildDashBoard({super.key});

  @override
  State<ChildDashBoard> createState() => _ChildDashBoardState();
}

class _ChildDashBoardState extends State<ChildDashBoard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ChildHomePage(),
    const ChildAnalysis(),
    const ChildBudget(),
  ];

  void _logout() async {
    // Clear saved data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); // This will remove all key-value pairs

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 67, 1, 49),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        title: const Text(
          'Spendify',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChildCalculator(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 137, 90, 145),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: const Text("My Account"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewProfile(who: 'child',),
                    ));
              },
            ),
            ListTile(
              title: const Text("About"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Feedback"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedbackPage(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Help"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Help(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Blog"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Blog(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey[800], // Set the unselected item color
        selectedItemColor: const Color.fromARGB(255, 67, 1, 49),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Budget'),
        ],
      ),
    );
  }
}
