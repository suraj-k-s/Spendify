import 'package:flutter/material.dart';

class Budgetlimt extends StatefulWidget {
  const Budgetlimt(
      {super.key,
      // required this.width,
      // required this.height,
      // required this.progress
      });
  // final double width;
  // final double height;
  // final double progress;
  @override
  State<Budgetlimt> createState() => _BudgetlimtState();
}

class _BudgetlimtState extends State<Budgetlimt> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Budgeted Categories:Apr,2024"),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 196, 115, 203),
                  child: Icon(Icons.brush),
                ),
                title: Text(
                  "Beauty",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.keyboard_control_outlined),
              ),
              const Row(
                children: [
                  Text("Limit: 5,000.00"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Apr,2024",
                    textAlign: TextAlign.end,
                  )
                ],
              ),
              const Row(
                children: [
                  Text("Spent: 2,500.00"),
                ],
              ),
              const Row(
                children: [Text("Remaining: 2,500")],
              ),
              Container(
                width: 20,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 20 * 15,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${(15 * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
