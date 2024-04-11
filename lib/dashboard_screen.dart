import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spendify/about.dart';
import 'package:spendify/analysis.dart';
import 'package:spendify/backuprestore.dart';
import 'package:spendify/budget.dart';
import 'package:spendify/category.dart';
import 'package:spendify/feedback.dart';
import 'package:spendify/help.dart';
import 'package:spendify/homepage.dart';
import 'package:spendify/calculator.dart';
import 'package:spendify/myaccount.dart';
import 'package:spendify/settings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const Analysis(),
    const Budget(),
    const Categories()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 67, 1, 49),
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
              builder: (context) => Calenders(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 137, 90, 145),
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
                      builder: (context) => Myaccount(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Setting"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ));
              },
            ),
            ListTile(
              title: const Text("About"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Backup and Restore"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BackupRestore(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Feedback"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackPage(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Help"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Help(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey[800], // Set the unselected item color
        selectedItemColor: Color.fromARGB(255, 67, 1, 49),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
        ],
      ),
    );
  }
}
