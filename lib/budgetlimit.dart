import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Budgetlimt extends StatefulWidget {
  const Budgetlimt({super.key, required this.width,required this.height,required this.progress});
final double width;
final double height;
final double progress;
  @override
  State<Budgetlimt> createState() => _BudgetlimtState();
}

class _BudgetlimtState extends State<Budgetlimt> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
          SingleChildScrollView(
            child:Column(children: [SizedBox(
          height: 30),
            Text("Budgeted Categories:Apr,2024"),
            Divider(),
             ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 196, 115, 203),
                child: Icon(Icons.brush),
              ),
              title: const Text(
                "Beauty",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_control_outlined),
             ),
            Row(children: [
              Text("Limit: 5,000.00"),
              SizedBox(
                width: 10,
              ),
              Text("Apr,2024",textAlign: TextAlign.end,)
            ],),
            Row(
              children: [
                Text("Spent: 2,500.00"),
              ],
            ),
            Row(
              children: [
                Text("Remaining: 2,500")
              ],
                ),
       Container(
              width: 20,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 20*15,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                 Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${(15*100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
            
                    ),
                  ),
                 ) 
                ],
              ),
            ),
            ],
            ),
    ),
      ],
    );
    
        
    
  }
}