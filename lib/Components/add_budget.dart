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
      title: const Text('Set Budget'),
      content: SizedBox(
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Flexible(child: Text("Limit")),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: _limitController,
                    decoration: const InputDecoration(
                      hintText: "0",
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Month: April,2024"),
            const SizedBox(
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ],
    );
  }
}
