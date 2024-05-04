import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Goalview extends StatefulWidget {
  const Goalview({super.key});

  @override
  State<Goalview> createState() => _GoalviewState();
}

class _GoalviewState extends State<Goalview> {
  void initState() {
    super.initState();
    getGoal();
  }

  List<Map<String, dynamic>> goalData = [];//empty list called goaldata is created
  Future<void> getGoal() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      List<Map<String, dynamic>> daily = [];
      QuerySnapshot<Map<String, dynamic>> totalSnapshot =
          await FirebaseFirestore.instance
              .collection('daily')
              .where('user_id', isEqualTo: userId)
              .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in totalSnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        data['id'] = documentSnapshot.id;
        print("Document: $data");
        DocumentSnapshot<Map<String, dynamic>> catSnap = await FirebaseFirestore
            .instance
            .collection('categories')
            .doc(data['category_id'])
            .get();
        if (catSnap.exists) {
          Map<String, dynamic>? catdata = catSnap.data();
          print('Category: $catdata');
          if (catdata != null) {
            data['category'] = catdata['name'];
            data['icon'] = catdata['icon'];
            data['type'] = catdata['type'];
          }
        }
        print("Document: $data");
        if (data['type'] == 'goals') {
          daily.add(data);
        }
      }
      setState(() {
        goalData = daily;
      });
    } catch (e) {
      print("Error Daily: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: getGoal,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: goalData.length,
              itemBuilder: (context, index) {
                final data = goalData[index];
                final int iconName = data['icon'] ?? 0;
                final String amount = data['amount'] ?? '';
                final String category = data['category'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange[200],
                        child:_buildIcon(iconName),
                      ),
                      title: Text(
                        category,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(amount),
                    ),
                  ],
                );
              },
            )
            // ListView(
            //       children: [
            // ListTile(
            //   leading: CircleAvatar(
            //     backgroundColor: Colors.deepOrange[200],
            //     child: Icon(Icons.cast_for_education),
            //   ),
            //   title: Text(
            //     "Education",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   trailing: Text("+2000"),
            // ),
            //       ],
            //     ),
            ));
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
