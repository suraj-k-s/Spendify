import 'package:flutter/material.dart';
import 'package:spendify/Components/popupblog.dart';
import 'package:spendify/data/blog_data.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: blogData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final String question = blogData[index]['QUESTION'];
          final String answer = blogData[index]['ANSWER'];
          final String image = blogData[index]['image'];

          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Popupblog(
                  question: question,
                  answer: answer,
                ),
              );
            },
            child: BudgetTip(
              image: image,
              question: question,
              answer: answer,
            ),
          );
        },
      ),
    );
  }
}

class BudgetTip extends StatelessWidget {
  final String image;
  final String question;
  final String answer;

  const BudgetTip({
    super.key,
    required this.image,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
