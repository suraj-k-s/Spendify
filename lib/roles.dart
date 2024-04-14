import 'package:flutter/cupertino.dart';
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
      backgroundColor: Color.fromARGB(255, 244, 185, 244),
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: SingleChildScrollView( 
          child:Column(children: [SizedBox(
          height: 30),
          Row(
            children: [
              Text("Selecting Roles",style: TextStyle(color: Colors.white,fontSize: 20),
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
                Icon(Icons.auto_awesome_rounded), 
                SizedBox(width: 10),
                Text("Father"),
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
                Icon(Icons.attach_money_outlined), 
                SizedBox(width: 10),
                Text("Mother"),
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
                Icon(Icons.auto_graph_outlined), 
                SizedBox(width: 10),
                Text("Son"),
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
                Icon(Icons.money), 
                SizedBox(width: 10),
                Text("Daughter"),

              ],
              ),
              ),
               Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Row(children: [Icon(Icons.add),
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
            ],)
          )
        ),);
  }
}
