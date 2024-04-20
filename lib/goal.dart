import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
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
                Text("Goals",style: TextStyle(color: Colors.white,fontSize: 20),
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
                  child:Center(child: Text("Education")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Vaccation")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Emergency")),
                ),
                Container(
                  margin:EdgeInsets.all(10),
                  width: 300,
                  height:100,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 207, 163, 207),
                  ),
                  child:Center(child: Text("Medical Funds")),
                ),
               
              ],)
            )
          ],),
  ),
      ),
);
}
}
