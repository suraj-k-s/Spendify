import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(124, 210, 130, 236),
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [SizedBox(
            height: 30),
            Row(
              children: [
                Text("Expense",style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Shopping")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Utilities")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Entertainment")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Food")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Medicals")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Subscription")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Transportation")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Electronics")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Childcare")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Rent/Mortgage")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Groceries")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Beauty")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Maintenance")),
                ),
              ],)
            )
          ],),
        ),),
    );
  }
}