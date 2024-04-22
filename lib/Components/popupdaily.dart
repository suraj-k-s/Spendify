import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PopupDaily extends StatelessWidget {
  final String type;
  final String amt;
  final DateTime date;
  final DateTime time;
  final String note;
  final String id;
  final int icon;
  final String category;
  const PopupDaily(
      {super.key,
      required this.type,
      required this.amt,
      required this.date,
      required this.time,
      required this.note,
      required this.id,
      required this.icon,
      required this.category});

  @override
  Widget build(BuildContext context) {
    Future<void> deleteDaily(id) async {
      try {
        await FirebaseFirestore.instance.collection('daily').doc(id).delete();
        Fluttertoast.showToast(
          msg: "Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);

      } catch (e) {
        print("Error Deleteing: $e");
        Fluttertoast.showToast(
          msg: "Deleting Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }

    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 48, 2, 35),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          deleteDaily(id);
                        },
                        icon: Icon(Icons.delete)),
                    // IconButton(onPressed: () {
                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Calenders(amt: amt,category: category
                    //   ,),));
                    // }, icon: Icon(Icons.edit)),
                  ],
                )
              ],
            ),
            Text(type,
                style: TextStyle(color: Colors.orangeAccent),
                textAlign: TextAlign.center),
            SizedBox(width: 10),
            Text('-$amt',
                style: TextStyle(color: Colors.orangeAccent),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            Text('${DateFormat('MMMM dd, yyyy hh:mm a').format(date)}',
                textAlign: TextAlign.right),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Category"),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        IconData(icon,
                            fontFamily:
                                'MaterialIcons'), // Use the icon data to display the icon
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(category),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
