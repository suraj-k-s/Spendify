import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Display Options',style:TextStyle(color:  Color.fromARGB(255, 245, 242, 246),)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: Text('Weekly',style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.pop(context);
              },
            
            ),
            ListTile(
              title: Text('Monthly',style: TextStyle(color: Colors.black),),
              onTap:(){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Yearly',style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
),
backgroundColor: Color.fromARGB(255, 137, 90, 145),
);
}
}