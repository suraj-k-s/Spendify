import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _textEditingController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: SafeArea(
       child: Column(
       
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter the feed back',
              ),
             ),
           ),
           TextButton(onPressed: (){}, child:Text('Cancel') ,
           ),
           TextButton(onPressed: (){}, 
           child: Text("Send Feedback"),
           ),
         ],
       ),
     ),
     );
     
  
  }
}
