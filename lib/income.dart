import 'package:flutter/material.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 244, 185, 244),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    "Income",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.auto_awesome_rounded),
                            SizedBox(width: 10),
                            Text("Awards"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money_outlined),
                            SizedBox(width: 10),
                            Text("Salary"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.auto_graph_outlined),
                            SizedBox(width: 10),
                            Text("Grand"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.money),
                            SizedBox(width: 10),
                            Text("Lottery"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.control_point_duplicate_outlined),
                            SizedBox(width: 10),
                            Text("Coupon"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 244, 185, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.business),
                            SizedBox(width: 10),
                            Text("Rental"),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
