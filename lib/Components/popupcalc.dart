import 'package:flutter/material.dart';

class Popupcal extends StatefulWidget {
  const Popupcal({super.key});

  @override
  State<Popupcal> createState() => _PopupcalState();
}

class _PopupcalState extends State<Popupcal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
           leading: const CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.wallet_giftcard_outlined),
                    
           ),
        ),

        
      ],
    );
  }
}