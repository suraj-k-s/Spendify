
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text("Income Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 98, 22, 113,),fontSize: 20)),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.wallet_giftcard_outlined),
                    ),
                    title: Text("Award",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                     ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 115, 184, 203),
                    child: Icon(Icons.attach_money_outlined),
                    ),
                    title: Text("Salary",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 132, 205, 123),
                    child: Icon(Icons.wallet_giftcard_sharp),
                    ),
                    title: Text("Grand",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 175, 130, 82),
                    child: Icon(Icons.money),
                    ),
                    title: Text("Lottery",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 169, 195, 90),
                    child: Icon(Icons.gif),
                    ),
                    title: Text("Coupons",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 103, 206, 141),
                    child: Icon(Icons.other_houses_outlined),
                    ),
                    title: Text("Rental",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                    ),
                    Text("Expense Category",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 98, 22, 113),fontSize: 20),),
                    Divider(),
                    ListTile(
              leading: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: Icon(Icons.shopping_cart),
                    ),
                    title: Text("Shopping",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                     ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 133, 203, 196),
                    child: Icon(Icons.fastfood),
                    ),
                    title: Text("Food",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 206, 106, 106),
                    child: Icon(Icons.local_hospital_outlined),
                    ),
                    title: Text("Medical",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 203, 115, 146),
                    child: Icon(Icons.attach_money_outlined),
                    ),
                    title: Text("Fuel",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 196, 211, 144),
                    child: Icon(Icons.water_drop_outlined),
                    ),
                    title: Text("Utilities",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 94, 176, 177),
                    child: Icon(Icons.baby_changing_station),
                    ),
                    title: Text("Childcare",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                    ),
                    ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 193, 109, 109),
                    child: Icon(Icons.miscellaneous_services_sharp),
                    ),
                    title: Text("Maintance",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 92, 153, 132),
                    child: Icon(Icons.live_tv),
                    ),
                    title: Text("SubScription",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 115, 203, 194),
                    child: Icon(Icons.bus_alert),
                    ),
                    title: Text("Transpotation",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 196, 115, 203),
                    child: Icon(Icons.face_retouching_natural),
                    ),
                    title: Text("Beauty",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                    ),
                    ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 148, 70, 70),
                    child: Icon(Icons.tv),
                    ),
                    title: Text("Entertainment",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 146, 192, 97),
                    child: Icon(Icons.other_houses_outlined),
                    ),
                    title: Text("Rent/Mortgage",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 206, 117, 72),
                    child: Icon(Icons.shopping_bag),
                    ),
                    title: Text("Groceries",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 72, 102, 150),
                    child: Icon(Icons.phone_android_rounded),
                    ),
                    title: Text("Electroincs",style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Icon(Icons.more_horiz),
                    ),    
                     Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Row(children: [Icon(Icons.add),
                   SizedBox(
                    width: 10,
                  ),
                   Text("Add new category"),
                  ],
                  ),

                ),
          ],
        
            ),
      ),
    );
  }
}