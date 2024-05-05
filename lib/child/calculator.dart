// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spendify/Components/category_sheet.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spendify/child/dashboard_screen.dart';
import 'package:spendify/service/parentdata.dart';

class ChildCalculator extends StatefulWidget {
  final String note = '';
  final String type = 'income';
  final String amt = '0';
  final String category = '';
  const ChildCalculator(
      {super.key,
      String id = '',
      String type = 'income',
      String amt = '0',
      String category = ''});

  @override
  State<ChildCalculator> createState() => _ChildCalculatorState();
}

class _ChildCalculatorState extends State<ChildCalculator> {
  String expression = '';
  String result = '0';
  String _type = "expense";
  String catButton = "Category";
  String uploadButton = "Add Bill";
  String? selectedCategory;
  final TextEditingController _noteController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  XFile? _selectedImage;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
        uploadButton = "Bill Uploaded";
      });
    }
  }

  void _handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        expression = '';
        result = '0';
      } else if (buttonText == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double evaluatedResult = exp.evaluate(EvaluationType.REAL, cm);
          result = evaluatedResult.toString();
        } catch (e) {
          result = 'Error';
        }
      } else if (buttonText == '←') {
        // Handling backspace
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
          result = expression.isEmpty ? '0' : expression;
        }
      } else {
        if (result == '0') {
          expression = buttonText;
          result = buttonText;
        } else {
          expression += buttonText;
          result = expression;
        }
      }
    });
  }

  void _handleSelectedCategory(String categoryId, String category) {
    setState(() {
      catButton = category;
      selectedCategory = categoryId;
    });
  }

  Future<void> checkDailyBudget() async {
    try {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
      final userId = await DataService.getData();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('daily')
          .where('user_id', isEqualTo: userId)
          .where('category_id', isEqualTo: selectedCategory)
          .where('date', isGreaterThanOrEqualTo: firstDayOfMonth.toString())
          .where('date', isLessThanOrEqualTo: lastDayOfMonth.toString())
          .get();
      double totalExpenses = 0.0;
      for (var doc in querySnapshot.docs) {
        totalExpenses += double.parse(doc['amount']);
      }
      double budget = 0;
      QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
          await FirebaseFirestore.instance
              .collection('budget')
              .where('category_id', isEqualTo: selectedCategory)
              .where('user_id', isEqualTo: userId)
              .limit(1)
              .get();
      if (querySnapshot2.docs.isNotEmpty) {
        budget = double.parse(querySnapshot2.docs.first['budget']);
      }
      totalExpenses += double.parse(result);
      double perc = (totalExpenses / budget) * 100;
      print("Percentage: $perc");
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      String formattedTime = '${_selectedTime.hour}:${_selectedTime.minute}';
      DocumentReference newDocumentRef =
          await _firestore.collection('daily').add({
        'user_id': userId,
        'category_id': selectedCategory,
        'note': _noteController.text,
        'amount': result,
        'date': formattedDate,
        'time': formattedTime,
        'bill': ''
      });

      String documentId = newDocumentRef.id;
      await _uploadImage(documentId);
      if (perc > 90.0 && perc <= 100.0 && budget != 0) {
        Fluttertoast.showToast(
          msg: "You are about to reach the monthly budget limit!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
        );
      } else if (totalExpenses >= budget && budget != 0) {
        Fluttertoast.showToast(
          msg: "You have exceeded your monthly budget!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Daily Added",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
      navigateMe();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard(),));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong. please try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print("Error checking budget: $e");
    }
  }

  Future<void> saveData() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    String formattedTime = '${_selectedTime.hour}:${_selectedTime.minute}';
    try {
      final userId = await DataService.getData();
      DocumentReference newDocumentRef =
          await _firestore.collection('daily').add({
        'user_id': userId,
        'category_id': selectedCategory,
        'note': _noteController.text,
        'amount': result,
        'date': formattedDate,
        'time': formattedTime,
        'bill': ''
      });

      String documentId = newDocumentRef.id;
      await _uploadImage(documentId);
      navigateMe();
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  Future<void> _uploadImage(String docId) async {
    try {
      if (_selectedImage != null) {
        Reference ref = FirebaseStorage.instance.ref().child('bill/$docId.jpg');
        UploadTask uploadTask = ref.putFile(File(_selectedImage!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('daily').doc(docId).update({
          'bill': imageUrl,
        });
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Handle error, show message or take appropriate action
    }
  }

  void navigateMe() {
    setState(() {
      _isLoading = false;
    });
    print("Navigating...");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChildDashBoard(),
        ));
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Function to show date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  // Function to show time picker dialog
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loading...")
                  ],
                ),
              ),
            )
          : SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (selectedCategory != null && result != '0') {
                            setState(() {
                              _isLoading = true;
                            });
                            checkDailyBudget();
                          } else if (selectedCategory == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Select Category"),
                                    content:
                                        const Text("Please select a category"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          } else if (result == '0') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Enter Amount"),
                                    content:
                                        const Text("Please enter an amount"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Something went wrong"),
                                    content: const Text("Please try again"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          "SAVE",
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 22, 113),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 22, 113),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Types

                  Row(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => CategoryBottomSheet(
                              onCategorySelected: _handleSelectedCategory,
                              type: _type,
                            ),
                          );
                        },
                        icon: const Icon(Icons.category),
                        label: Text(
                          catButton,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 67, 1, 49),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: Text(
                          uploadButton,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 67, 1, 49),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      controller: _noteController,
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: null,
                    ),
                  ),

                  //Calculator Screen
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              result,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _handleButtonPress('←');
                              },
                              icon: const Icon(
                                  Icons.backspace_outlined)) // backspace
                        ],
                      ),
                    ),
                  ),

                  // Calculator Buttons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                            _buildButton('/'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                            _buildButton('*'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                            _buildButton('-'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('.'),
                            _buildButton('0'),
                            _buildButton('C'),
                            _buildButton('+'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _handleButtonPress('=');
                              },
                              child: const Text(
                                '=',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${_selectedDate.day} ${_getMonthName(_selectedDate.month)}, ${_selectedDate.year}',
                            ), // Date
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height:
                                20, // Adjust the height of the line as needed
                            width: 1, // Adjust the width of the line as needed
                            color: Colors
                                .black, // Adjust the color of the line as needed
                            margin: const EdgeInsets.symmetric(
                                horizontal:
                                    8), // Adjust the spacing around the line as needed
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${_selectedTime.hour}:${_selectedTime.minute} ${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                            ), // Time
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          _handleButtonPress(buttonText);
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
