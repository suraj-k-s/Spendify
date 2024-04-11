
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({super.key});

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center (
     child: Text("MyAccount"),
      ),
     
    );
  }
}