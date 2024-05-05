// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:spendify/Components/appbar.dart';
import 'package:spendify/edit_profile.dart';
import 'package:spendify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProfile extends StatefulWidget {
  final String who;
  const ViewProfile({super.key, required this.who});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String? id = '';
  String name = '';
  String gender = '';
  String image = 'assets/dummy-profile-pic.png';
  List<Map<String, dynamic>> userDocs = [];

  Future<void> loaduserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final firestore = FirebaseFirestore.instance;
    final userCollection = firestore.collection(widget.who);

    final query = userCollection.doc(userId);

    DocumentSnapshot querySnapshot;
    try {
      querySnapshot = await query.get();
    } catch (error) {
      print('Error getting documents: $error');
      rethrow;
    }
    userDocs.clear();
    if (querySnapshot.exists) {
      
        id = querySnapshot.id;
      Map<String, dynamic> documentData =
          querySnapshot.data() as Map<String, dynamic>;

      documentData['id'] = querySnapshot.id;

      if (name.isEmpty) {
        name = documentData['name'];
        gender = documentData['gender'];
        image = documentData.containsKey('imageUrl')
            ? documentData['imageUrl']
            : '';
      }
      userDocs.add(documentData);
    }
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loaduserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Logo.png', 
                    height: 150,
                  ),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            return buildProfileContent();
          }
        },
      ),
    );
  }

  Widget buildProfileContent() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/Vector-1.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          )),
      child: ListView(
        children: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View Profile',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set background color
                        foregroundColor:
                            AppColors.primaryColor, // Set text color
                        side: const BorderSide(
                            color: AppColors.primaryColor), // Add black border
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(userId: id, who: widget.who,)));
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 180,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 220, 231, 253)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 216, 225, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: (image != ""
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 80,
                          )
                        : Image.asset('assets/dummy-profile-pic.png',
                            height: 100, width: 80, fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'user Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
