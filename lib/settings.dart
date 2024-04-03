import 'package:flutter/material.dart';
import 'package:spendify/Components/appbar.dart';
import 'package:spendify/login_screen.dart';
import 'package:spendify/main.dart';
import 'package:spendify/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool check = false;

class _SettingsScreenState extends State<SettingsScreen> {
  bool isHomeListVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/Vector-1.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        )),
        child: ListView(
          children: [
            const CustomAppBar(
              settings: false,
            ),
            const SizedBox(
                height: 80,
                child: Center(
                    child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ))),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewProfile()));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 83, 128, 196)),
                child: const Text(
                  "Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHomeListVisible = !isHomeListVisible;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 231, 253)),
                child: const Text(
                  "Home",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (isHomeListVisible)
             Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 231, 253)),
              child: const Text(
                "Contact",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 83, 128, 196)),
              child: const Text(
                "Share",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 231, 253)),
              child: const Text(
                "Rate the app",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                _logout();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.red, // Customize the color as needed
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    // Clear saved data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); // This will remove all key-value pairs

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
