import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Inviteparent extends StatefulWidget {
  const Inviteparent({super.key});

  @override
  State<Inviteparent> createState() => _InviteparentState();
}

class _InviteparentState extends State<Inviteparent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Create Referal id",
                  textAlign: TextAlign.center,
                ),),
        
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("Your referal id is:"),
              ],
               
            )
            
          ],
        
      ),
              
      ),
    );
    
  }
}
