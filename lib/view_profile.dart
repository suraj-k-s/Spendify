import 'package:flutter/material.dart';
import 'package:spendify/Components/appbar.dart';
import 'package:spendify/edit_profile.dart';
import 'package:spendify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String? id = '';
  String name = '';
  String gender = '';
  String dob = '';
  String image = 'assets/dummy-profile-pic.png';
  List<Map<String, dynamic>> userDataList = [];

  List<Map<String, dynamic>> userDocs = [];

  Future<void> loaduserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final firestore = FirebaseFirestore.instance;
    final userCollection = firestore.collection('user');

    final query = userCollection.where('userId', isEqualTo: userId);

    QuerySnapshot querySnapshot;
    try {
      querySnapshot = await query.get();
    } catch (error) {
      print('Error getting documents: $error');
      // You might want to throw an error or handle it as needed
      rethrow;
    }
    userDocs.clear();
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      // Access the data in each document
      // print('${document.id} => ${document.data()}');
      if (id == '') {
        id = document.id;
        print('ID: ${document.id}');
      }
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;

      // Add the 'id' field to documentData
      documentData['id'] = document.id;

      if (name.isEmpty) {
        name = documentData['name'];
        gender = documentData['gender'];
        image = documentData.containsKey('imageUrl')
            ? documentData['imageUrl']
            : '';
        
      }
      userDocs.add(documentData);
    });
  }

  void _userChange(Map<String, dynamic> selecteduser) {
    print(selecteduser);

    setState(() {
      id = selecteduser['id'] ?? '';
      name = selecteduser['name'] ?? '';
      gender = selecteduser['gender'] ?? '';
      image = selecteduser['imageUrl'] ?? '';
    });
  }

  void _showuserDetailsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'childrens',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 28),
              ),
            ),
            GridView.builder(
              itemCount: userDocs.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8, // Adjust this aspect ratio as needed
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _userChange(userDocs[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xff4c505b),
                        backgroundImage: userDocs[index]['imageUrl'] != null
                            ? NetworkImage(userDocs[index]['imageUrl']!)
                            : const AssetImage('assets/dummy-profile-pic.png')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 8), // Adjust spacing between items
                      Text(
                        userDocs[index]['name'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loaduserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while data is being fetched
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Logo.png', // Replace with the path to your logo
                    height: 150,
                  ),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // Handle the error if loading fails
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            // Data has been successfully loaded, display the main content
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
                                builder: (context) =>
                                    EditProfile(userId: id)));
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
                  IconButton(
                      onPressed: () {
                        _showuserDetailsModal(context);
                      },
                      icon: const Icon(Icons.arrow_drop_down_circle))
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
