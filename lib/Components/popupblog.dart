import 'package:flutter/material.dart';

class Popupblog extends StatelessWidget {
  final String question;
  final String answer;
  const Popupblog({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(question),
          content: SingleChildScrollView(
            child: Text(answer),
          ),
          actions: <Widget>[
           ElevatedButton.icon(onPressed: (){
            Navigator.pop(context);
           }, icon: Icon(Icons.close), label: Text("Close"))
          ],
        );
  }
}
    
    
    
  
