import 'package:flutter/material.dart';

class PopupCategory extends StatelessWidget {
  const PopupCategory({super.key});

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
                    )),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                )
              ],
            ),
            
            const Text("Expense",style: TextStyle(color: Colors.orangeAccent),textAlign: TextAlign.center,),
            const SizedBox(
              width: 10,
            ),
            const Text("-500",style: TextStyle(color: Colors.orangeAccent),textAlign: TextAlign.center,),
            const SizedBox(
              height: 20,
            ),
            Text("April 07,2024 3:00 PM",textAlign: TextAlign.right,),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Category"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Row(children: [Icon(Icons.card_giftcard_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Gifts"),
                  ],
                  ),

                ),
              ],
              ),
              
          ]
          
        ),
          
        ),
      );
    
  }
}
