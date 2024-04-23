import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryBottomSheet extends StatelessWidget {
  final String type;
  final Function(String, String) onCategorySelected;
  const CategoryBottomSheet(
      {super.key, required this.type, required this.onCategorySelected});

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
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('categories')
                .where('type', isEqualTo: type)
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
                  'icon':
                      IconData(data['icon'] ?? 0, fontFamily: 'MaterialIcons'),
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
                        return GestureDetector(
                          onTap: () {
                            onCategorySelected(cat['id'],
                                cat['name']); // Call the callback function with the selected category ID
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(cat['icon']), Text(cat['name'])],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
