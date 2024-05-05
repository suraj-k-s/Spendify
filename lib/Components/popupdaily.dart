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
    super.key,
    required this.type,
    required this.amt,
    required this.date,
    required this.time,
    required this.note,
    required this.id,
    required this.icon,
    required this.category,
    required this.bill,
  });

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
                  icon: const Icon(
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
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
            Text(
              type,
              style: const TextStyle(color: Colors.orangeAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 10),
            Text(
              '-$amt',
              style: const TextStyle(color: Colors.orangeAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              DateFormat('MMMM dd, yyyy hh:mm a').format(date),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Category"),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                        _buildIcon(icon),
                      const SizedBox(width: 10),
                      Text(category),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Bill:-'),
            const SizedBox(
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
                : const Text('No Bill Added'),
          ],
        ),
      ),
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

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
