import 'package:flutter/material.dart';

class Budgetlimt extends StatefulWidget {
  final String date;
  final String time;
  final String exp;
  final String budget;
  final String id;
  final String category;
  final int icon;
  final double value;
  const Budgetlimt({
    super.key,
    required this.date,
    required this.time,
    required this.exp,
    required this.budget,
    required this.id,
    required this.category,
    required this.icon,
    required this.value,
  });

  @override
  State<Budgetlimt> createState() => _BudgetlimtState();
}

class _BudgetlimtState extends State<Budgetlimt> {
  @override
  Widget build(BuildContext context) {
    double prVal = widget.value.toDouble();
    double remaining = double.parse(widget.budget) - double.parse(widget.exp);
    return Column(
      children: [
        const SizedBox(height: 10),
        Text("Budgeted Categories: ${widget.date}"),
        const Divider(),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 196, 115, 203),
              child: Icon(
                IconData(widget.icon, fontFamily: 'MaterialIcons'),
                size: 24,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.category,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Limit: ${widget.budget}"),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Spent: ${widget.exp}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Remaining: ${remaining.toString()}")
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.keyboard_control),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: LinearProgressIndicator(
            minHeight: 15,
            value: prVal,
          ),
        ),
      ],
    );
  }
}
