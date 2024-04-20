import 'package:flutter/material.dart';
import 'package:spendify/expense.dart';
import 'package:spendify/goal.dart';
import 'package:spendify/income.dart';
import 'package:spendify/photoadd.dart';
import 'package:spendify/roles.dart';

class Calenders extends StatefulWidget {
  const Calenders({super.key});

  @override
  State<Calenders> createState() => _CalendersState();
}

class _CalendersState extends State<Calenders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
              Text(
                "SAVE",
                style: TextStyle(
                  color: Color.fromARGB(255, 98, 22, 113),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.cancel)),
              Text(
                "CANCEL",
                style: TextStyle(
                  color: Color.fromARGB(255, 98, 22, 113),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Expense(),
                      ));
                },
                child: Text(
                  "EXPENSE",
                  style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
                ),
              ),
              SizedBox(
                width: 20,
              ),
             TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Income(),
                      ));
                },
              child:Text(
                "INCOME",
                style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
              ),
             ),
              SizedBox(
                width: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Goals(),
                      ));
                },
                 child:  Text(
                "GOAL",
                style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
              ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.category),
                label: Text(
                  'Category',
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 1, 49),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Roles(),
                      ));
                },
                icon: Icon(Icons.camera_alt),
                label: Text(
                  "Add Photo",
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 1, 49),
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: null,
          ),
          Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(15)),
                  padding: EdgeInsets.all(10),
                  child: const Row(
                    children: [
                  Icon(Icons.backspace,),
                   SizedBox(
                    width: 10,
                  ),
                   Text("0",
               
                   style: TextStyle(fontWeight: FontWeight.bold),
                   textAlign: TextAlign.right,
                   ),
                  ],
                  ),

                ),
          SizedBox(
            height: 100,
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('7'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('8'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('9'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '+',
                      selectionColor: Color.fromARGB(255, 58, 25, 58),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('4'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('5'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('6'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '-',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('1'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('2'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('3'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '*',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '.',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('0'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '()',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '/',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'AC',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '=',
                    selectionColor: Color.fromARGB(255, 58, 25, 58),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
