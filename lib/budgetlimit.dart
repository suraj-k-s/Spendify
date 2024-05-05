import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spendify/Components/add_budget.dart';

class Budgetlimt extends StatefulWidget {
  final String date;
  final String time;
  final String exp;
  final String budget;
  final String id;
  final String category;
  final int icon;
  final double value;
  final bool edit;
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
    this.edit=true
  });

  @override
  State<Budgetlimt> createState() => _BudgetlimtState();
}

class _BudgetlimtState extends State<Budgetlimt> {
  Future<void> deleteItem(String id) async {
      try {
        await FirebaseFirestore.instance
            .collection('budget')
            .doc(id)
            .delete();
        Fluttertoast.showToast(
          msg: "Data deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        print("Error deleting document: $error");
        Fluttertoast.showToast(
          msg: "Error deleting data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    double prVal = widget.value.toDouble();
    double remaining = double.parse(widget.budget) - double.parse(widget.exp);
    return Column(
      children: [
        const SizedBox(height: 10),
        Text("Budgeted Categories: ${widget.date}"),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 196, 115, 203),
            child: _buildIcon(widget.icon)
          ),
          title: Text(
            widget.category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text("Remaining: ${remaining.toString()}"),
            ],
          ),
          trailing: widget.edit ? PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Change Limit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBudget(
                        docId: '',
                        category: widget.category,
                        icon: widget.icon,
                        amt: widget.budget,
                        id: widget.id,
                      ),
                    ));
              } else if (value == 'delete') {
                deleteItem(widget.id);
              }
            },
          ): null,
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
  Widget _buildIcon(int iconName) {
    return Text(
      String.fromCharCode(iconName),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'MaterialIcons',
      ),
    );
  }
}
