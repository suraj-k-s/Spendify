import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(124, 210, 130, 236),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    "Goals",
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
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Education")),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Vaccation")),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Emergency")),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Medical Funds")),
                      ),
                       Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Debt Payment")),
                      ),
                       Container(
                        margin: const EdgeInsets.all(10),
                        width: 300,
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 207, 163, 207),
                        ),
                        child: const Center(child: Text("Buying Utensils")),
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
