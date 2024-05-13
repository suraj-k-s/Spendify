import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "ABOUT",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: Text(
                    "Welcome to Spendify, your comprehensive solution for managing family finances and achieving financial stability. With Spendify, you can easily track your expenses, create customized budgets, set savings goals, and stay on top of bills and payments, all in one place. Our mission is to empower families to take control of their finances and build a secure future. Developed by a dedicated team of financial experts and tech enthusiasts, Spendify combines simplicity and functionality to help you make informed financial decisions and achieve your goals. Your privacy and security are our top priorities, and we employ industry-leading measures to protect your financial data. We're here to support you every step of the way on your journey to financial wellness. Thank you for choosing Spendify lets start managing your finances together!")),
          ],
        ),
      ),
    );
  }
}
