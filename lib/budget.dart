import 'package:flutter/material.dart';
import 'package:spendify/Components/add_budget.dart';
import 'package:spendify/budgetlimit.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Not budgeted this month",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 196, 115, 203),
                        child: Icon(Icons.face_retouching_natural),
                      ),
                      title: const Text(
                        "Beauty",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Add_Budget(); // Using the MyDialog widget
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                    ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[200],
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                        title: const Text(
                          "Shopping",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 196, 211, 144),
                          child: Icon(Icons.electric_bolt),
                        ),
                        title: const Text(
                          "Utilities",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 148, 70, 70),
                          child: Icon(Icons.tv),
                        ),
                        title: const Text(
                          "Entertainment",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 92, 153, 132),
                          child: Icon(Icons.live_tv),
                        ),
                        title: const Text(
                          "Subscription",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 206, 106, 106),
                          child: Icon(Icons.local_hospital_outlined),
                        ),
                        title: const Text(
                          "Medical",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 133, 203, 196),
                          child: Icon(Icons.fastfood),
                        ),
                        title: const Text(
                          "Food",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 193, 109, 109),
                          child: Icon(Icons.build_sharp),
                        ),
                        title: const Text(
                          "Maintenance",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 115, 203, 194),
                          child: Icon(Icons.directions_bus_filled_outlined),
                        ),
                        title: const Text(
                          "Transportation",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 94, 176, 177),
                          child: Icon(Icons.baby_changing_station_outlined),
                        ),
                        title: const Text(
                          "Childcare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 146, 192, 97),
                          child: Icon(Icons.other_houses_outlined),
                        ),
                        title: const Text(
                          "Rent/Mortgage",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 206, 117, 72),
                          child: Icon(Icons.shopping_bag),
                        ),
                        title: const Text(
                          "Groceries",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: const Text("Set Budget"),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 72, 102, 150),
                          child: Icon(Icons.phone_android_rounded),
                        ),
                        title: const Text(
                          "Electronics",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Add_Budget(); // Using the MyDialog widget
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: const Text("Set Budget"),
                          ),
                        ),
                  
                      ),
                  ]
                );
  
     
     
  }
}
