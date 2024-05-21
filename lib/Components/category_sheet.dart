import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendify/service/childData.dart';
import 'package:spendify/service/userData.dart';

class CategoryBottomSheet extends StatelessWidget {
  final String type;
  final bool child;
  final Function(String, String) onCategorySelected;
  const CategoryBottomSheet(
      {super.key,
      required this.type,
      required this.onCategorySelected,
      this.child = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Categories',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: FutureBuilder(
              future: child
                  ? ChildDataService.getData()
                  : UserDataService.getData(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Text(
                      'Error: ${snapshot.error}'); // Handle error if unable to fetch user ID
                }

                final String familyId = snapshot.data!;
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .where('type', isEqualTo: type)
                      .where('family', isEqualTo: familyId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<Map<String, dynamic>> categories = [];

                    for (var doc in snapshot.data!.docs) {
                      var data = doc.data() as Map<String, dynamic>;
                      final category = {
                        'id': doc.id,
                        'name': data['name'],
                        'icon': data['icon'],
                        'type': data['type'],
                      };
                      categories.add(category);
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final cat = categories[index];
                              int icon = cat['icon'];
                              return GestureDetector(
                                onTap: () {
                                  onCategorySelected(cat['id'],
                                      cat['name']); // Call the callback function with the selected category ID
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildIcon(icon),
                                    Text(cat['name'])
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ],
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
