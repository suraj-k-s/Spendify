import 'package:flutter/material.dart';

class Add_Budget extends StatefulWidget {
  const Add_Budget({super.key});

  @override
  State<Add_Budget> createState() => _Add_BudgetState();
}

class _Add_BudgetState extends State<Add_Budget> {

final TextEditingController _limitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Budget'),
      content: Container(
        height: 250,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all()),
              child: const Row(
                children: [
                  Icon(Icons.brush),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Beauty',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(child: Text("Limit")),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: _limitController,
                    decoration: InputDecoration(
                     hintText: "0",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("Month: April,2024"),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
    );
  }
}
