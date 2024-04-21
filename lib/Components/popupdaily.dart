import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class PopupDaily extends StatelessWidget {
  final String type;
  final String amt;
  final DateTime date;
  final DateTime time;
  final String note;
  final String id;
  final int icon;
  final String category;
  final String bill;

  const PopupDaily({
    Key? key,
    required this.type,
    required this.amt,
    required this.date,
    required this.time,
    required this.note,
    required this.id,
    required this.icon,
    required this.category,
    required this.bill,
  }) : super(key: key);

  Future<void> deleteDaily(BuildContext context) async {
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
      print("Error Deleting: $e");
      Fluttertoast.showToast(
        msg: "Deleting Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        deleteDaily(context);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
            Text(
              type,
              style: TextStyle(color: Colors.orangeAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 10),
            Text(
              '-$amt',
              style: TextStyle(color: Colors.orangeAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '${DateFormat('MMMM dd, yyyy hh:mm a').format(date)}',
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Category"),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        IconData(icon, fontFamily: 'MaterialIcons'),
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(category),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Bill:-'),
            SizedBox(
              height: 10,
            ),
            bill != ''
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl: bill,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 300,
                      child: Image.network(bill, fit: BoxFit.cover)),
                  )
                : Text('No Bill Added'),
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
