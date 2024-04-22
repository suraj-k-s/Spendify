import 'package:flutter/material.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text("Date"),
              Text("2020/09/03 (THU) 4:00"),
            ],
          ),
          Row(
            children: [
              Text("Category"),
              Text("Food/Eating"),
            ],
          ),
          Row(
            children: [
              Text("Amount"),
              Text("6544"),
            ],
          ),
          Row(
            children: [
              Text("Note"),
              Text("Fried Chicken"),
            ],
          ),
          // Row(children: [
          //   Column(
          //  children: [
          //   Icon(Icons.save): Icon(Icons.save),
          //   label: Text("Save,",style: TextStyle(color: Color.fromARGB(255, 58, 25, 58))),
          //  ]
          //   )
          // ]
          // ),
          // ]
        ],
      ),
    );
  }
}
