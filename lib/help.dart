import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spendify/data/helpquestions.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: ListView.builder(
      itemCount:HelpData.length,
      shrinkWrap: true,
       itemBuilder: (context, index) {
        final String question = HelpData[index]['QUESTION'];
        final String answer = HelpData[index]['ANSWER'];

      return ListTile(
        title: Text(question),
        subtitle: Text(answer),
        
       );
       
       },
       
    ),
    );
    
  }
}
