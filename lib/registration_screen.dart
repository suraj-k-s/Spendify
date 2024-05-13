// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spendify/data/categoryData.dart';
import 'package:spendify/login_screen.dart';
import 'dart:io';
import 'package:spendify/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spendify/referalscannner.dart';

class RegistrationScreen extends StatefulWidget {
  final String refId;
  final bool parent;
  const RegistrationScreen({super.key, this.refId = '', this.parent=false});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  String? _imageUrl;
  String? _selectedGender = '';
  bool genderCheck = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          _loading = true;
        });

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passController.text,
        );
        if (widget.refId == '') {
          await _storeUserData(userCredential.user!.uid);
        } else if(widget.parent) {
          await _storeMemberData(userCredential.user!.uid, 'users');
        }
        else {
          await _storeMemberData(userCredential.user!.uid, 'child');
        }
        Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        setState(() {
          _loading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
        msg: "Registration Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      if (kDebugMode) {
        print("Error registering user: $e");
      }
    }
  }

  Future<void> _storeMemberData(String userId, String collection) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection(collection).doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _selectedGender,
        'password': _passController.text,
        'parent_id': widget.refId,
      });

      await _uploadImage(userId);
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  Future<void> _storeUserData(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _selectedGender,
        'password': _passController.text,
        'family': userId,
      });

      await _uploadImage(userId);
      if (widget.refId == '') {
        await _storeCategory(userId);
      }
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  Future<void> _uploadImage(String userId) async {
    try {
      if (_selectedImage != null) {
        Reference ref =
            FirebaseStorage.instance.ref().child('user_images/$userId.jpg');
        UploadTask uploadTask = ref.putFile(File(_selectedImage!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> _storeCategory(userId) async {
    final firestore = FirebaseFirestore.instance;
    final categoriesCollection = firestore.collection('categories');

    try {
      for (var category in categoryData) {
        await categoriesCollection.add({
          'userId': userId,
          'name': category['name'],
          'icon': category['icon'].codePoint,
          'type': category['type'],
        });
      }
    } catch (e) {
      print('Error inserting categories: $e');
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 138, 183, 219),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 245, 251, 255),
              Color.fromARGB(255, 175, 203, 244),
            ],
            radius: .5,
            center: Alignment(0.2, -.6),
          )),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.refId==''? 
                          'Parent Registration':'Child Registration',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                            'Please make sure all the details are right.'),
                        if(widget.refId == '')
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QRScanner(),
                                  ));
                            },
                            child: const Text('Click here if you have referal')),
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: const Color(0xff4c505b),
                                  backgroundImage: _selectedImage != null
                                      ? FileImage(File(_selectedImage!.path))
                                      : _imageUrl != null
                                          ? NetworkImage(_imageUrl!)
                                          : const AssetImage(
                                                  'assets/dummy-profile-pic.png')
                                              as ImageProvider,
                                  child: _selectedImage == null &&
                                          _imageUrl == null
                                      ? const Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 134, 134, 134),
                                        )
                                      : null,
                                ),
                                if (_selectedImage != null || _imageUrl != null)
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.white,
                                      radius: 18,
                                      child: Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: _validateName,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          validator: _validatePhoneNumber,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Select Gender'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Male'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Female'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.primaryColor,
                                  value: 'Other',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Other'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!genderCheck)
                          const Text(
                            'Please select a gender',
                            style: TextStyle(color: Colors.red),
                          ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _passController,
                          validator: _validatePassword,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: _togglePasswordVisibility,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            hintText: 'Password',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 25.0,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(241, 241, 241, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: _loading
                                    ? const Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (genderCheck &&
                                              _formKey.currentState!
                                                  .validate()) {
                                            _registerUser();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 15, 10.0, 15),
                                        ),
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.white),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
