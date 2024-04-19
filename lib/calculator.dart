import 'package:flutter/material.dart';
import 'package:spendify/expense.dart';
import 'package:math_expressions/math_expressions.dart';

class Calenders extends StatefulWidget {
  const Calenders({super.key});

  @override
  State<Calenders> createState() => _CalendersState();
}

class _CalendersState extends State<Calenders> {
  String expression = '';
  String result = '0';

  void _handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        expression = '';
        result = '0';
      } else if (buttonText == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double evaluatedResult = exp.evaluate(EvaluationType.REAL, cm);
          result = evaluatedResult.toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (result == '0') {
          expression = buttonText;
          result = buttonText;
        } else {
          expression += buttonText;
          result = expression;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(),
      body: Column(
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
              Text(
                "INCOME",
                style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "GOAL",
                style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),
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
                onPressed: () {},
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
            minLines: 4,
            maxLines: null,
          ),
          //Calculator Screen
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(5)),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
      
          // Calculator Buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('*'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('.'),
                      _buildButton('0'),
                      _buildButton('C'),
                      _buildButton('+'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress('=');
                        },
                        child: Text(
                          '=',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            _handleButtonPress(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
