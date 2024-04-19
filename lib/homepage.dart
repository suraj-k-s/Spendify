import 'package:flutter/material.dart';
import 'package:spendify/Components/filtersheet.dart';
import 'package:spendify/Components/popupcategory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(255, 48, 2, 35),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  "May,2024",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Color.fromARGB(255, 48, 2, 35),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const FilterSheet(),
                    );
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    color: Color.fromARGB(255, 48, 2, 35),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("EXPENSE",style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),),
                Text("5000",style: TextStyle(color: Colors.black),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  
                ),
                Text("INCOME",style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),),
                Text("6000",style: TextStyle(color: Colors.black),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("TOTAL",style: TextStyle(color: Color.fromARGB(255, 67, 1, 49)),),
                Text("11000",style: TextStyle(color: Colors.black),),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ListView(
          shrinkWrap: true,
          children:  [
            Text("April 06, Saturday",style: TextStyle(fontSize: 15),),
            Divider(),
            ListTile(
              onTap: () {
                showDialog(context: context, builder: (context) => const PopupCategory(),);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.card_giftcard_sharp),
                ),
                title: Text("Gifts",style: TextStyle(fontWeight: FontWeight.bold,),),
                trailing: Text("-500",style: TextStyle(fontSize: 18,color: Colors.amberAccent),),
              ),
                 ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 203, 115, 146),
                child: Icon(Icons.attach_money),
                ),
                title: Text("Salary",style: TextStyle(fontWeight: FontWeight.bold,),),
                trailing: Text("+10000",style:TextStyle(fontSize: 18,color: Colors.purpleAccent)),
              ),
          ],
        ),
      ],
    );
  }
}


