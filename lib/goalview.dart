import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Goalview extends StatefulWidget {
  const Goalview({super.key});

  @override
  State<Goalview> createState() => _GoalviewState();
}

class _GoalviewState extends State<Goalview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Column(
    children: [
      ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.deepOrange[200],
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Education",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+2000"),
      
      ),
       ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.blueGrey[200],
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Vaccation",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+7000"),
      ),
      ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.brown[600],
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Emergency",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+6000"),
      ),
      ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Medical Funds",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+5000"),
      ),
      ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.lime,
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Debt Payment",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+3000"),
      ),
        ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Icon(Icons.cast_for_education),
       ),
       title:Text("Buying Utensils",style: TextStyle(fontWeight: FontWeight.bold),),
       trailing: Text("+4000"),
      ),
    ],

   )
    );
  }
}