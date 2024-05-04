import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReferenceCode extends StatefulWidget {
  const ReferenceCode({super.key});

  @override
  State<ReferenceCode> createState() => _ReferenceCodeState();
}

class _ReferenceCodeState extends State<ReferenceCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
      child:Column(
        children: [
          Row(
            children: [
              Text("Enter Referal Code"),
              SizedBox(
                height: 20,
              )
            ],
          ),
          Row(
            children: [
              TextFormField()
            ],
),
Row(
  children: [
    ElevatedButton(onPressed: (){}, child:Text("Continue"))
  ],
  
)

        ],
        
      ),
      
     ),
    );
  }
}