import 'package:flutter/material.dart';
import 'package:spendify/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

const IconData copyright = IconData(0xe198, fontFamily: 'MaterialIcons');

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/Vector-1.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/gif.gif',
                      fit: BoxFit.contain,
                      width: 250,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                '© Copyright PSST 2024',
                style: TextStyle(
                    color: Colors.white, fontSize: 15, letterSpacing: .7),
              ),
            )
          ],
        ),
      ),
    );
  }

  void gotoLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
}
