import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Not budgeted this month",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 196, 115, 203),
              child: Icon(Icons.face_retouching_natural),
            ),
            title: Text(
              "Beauty",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
          ),
           ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[200],
              child: Icon(Icons.shopping_cart_outlined),
            ),
            title: Text (
              "Shopping",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 196, 211, 144),
              child: Icon(Icons.electric_bolt),
            ),
            title: Text (
              "Utilities",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
            ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 148, 70, 70),
              child: Icon(Icons.tv),
            ),
            title: Text (
              "Entertainment",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
            ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 92, 153, 132),
              child: Icon(Icons.live_tv),
            ),
            title: Text (
              "Subscription",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 206, 106, 106),
              child: Icon(Icons.local_hospital_outlined),
            ),
            title: Text (
              "Medical",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 133, 203, 196),
              child: Icon(Icons.fastfood),
            ),
            title: Text (
              "Food",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 193, 109, 109),
              child: Icon(Icons.build_sharp),
            ),
            title: Text (
              "Maintenance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 115, 203, 194),
              child: Icon(Icons.directions_bus_filled_outlined),
            ),
            title: Text (
              "Transportation",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 94, 176, 177),
              child: Icon(Icons.baby_changing_station_outlined),
            ),
            title: Text (
              "Childcare",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 146, 192, 97),
              child: Icon(Icons.other_houses_outlined),
            ),
            title: Text (
              "Rent/Mortgage",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 206, 117, 72),
              child: Icon(Icons.shopping_bag),
            ),
            title: Text (
              "Groceries",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
             ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 72, 102, 150),
              child: Icon(Icons.phone_android_rounded),
            ),
            title: Text (
              "Electronics",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text("Set Budget"),
            ),
            ),
        ],
      ),
    );
  }
}
           
          