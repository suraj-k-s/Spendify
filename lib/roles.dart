import 'package:flutter/material.dart';

class Roles extends StatefulWidget {
  const Roles({super.key});

  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
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
                    "Selecting Roles",
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
                          Icon(Icons.man),
                          SizedBox(width: 10),
                          Text("Father"),
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
                          Icon(Icons.woman_outlined),
                          SizedBox(width: 10),
                          Text("Mother"),
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
                          Icon(Icons.child_care_outlined),
                          SizedBox(width: 10),
                          Text("Son"),
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
                          Icon(Icons.girl_sharp),
                          SizedBox(width: 10),
                          Text("Daughter"),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Add Profile"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
