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
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 249, 246, 250),
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: SingleChildScrollView( 
          child:Column(children: [SizedBox(
          height: 30),
          Row(
            children: [
             Text("Expense",style: TextStyle(color: Colors.purpleAccent,fontSize: 20),
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
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.shopping_cart), 
                SizedBox(width: 10),
                Text("Shopping"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.electric_bolt_outlined), 
                SizedBox(width: 10),
                Text("Utilities"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.tv), 
                SizedBox(width: 10),
                Text("Entertainment"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.fastfood), 
                SizedBox(width: 10),
                Text("Food"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.local_hospital), 
                SizedBox(width: 10),
                Text("Medicals"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.live_tv), 
                SizedBox(width: 10),
                Text("Subscription"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.directions_bus_filled_sharp), 
                SizedBox(width: 10),
                Text("Transportation"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.phone_android), 
                SizedBox(width: 10),
                Text("Electronics"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(2255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.baby_changing_station), 
                SizedBox(width: 10),
                Text("Childcare"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.business), 
                SizedBox(width: 10),
                Text("Rent/Mortgage"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.add_shopping_cart_outlined), 
                SizedBox(width: 10),
                Text("Groceries"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.face_retouching_natural_sharp), 
                SizedBox(width: 10),
                Text("Beauty"),
              ],
              ),
              ),
              Container(
                margin:EdgeInsets.all(10),
                width: 300,
                height:100,
                padding: EdgeInsets.all(20),
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 244, 185, 244),
                ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.build_rounded), 
                SizedBox(width: 10),
                Text("Maintenance"),
              ],
              ),
              ),
            ],)
          )
        ],),),
      ),
    );
  }
}