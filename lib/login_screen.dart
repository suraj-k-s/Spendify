import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendify/child/dashboard_screen.dart';
import 'package:spendify/main.dart';
import 'dashboard_screen.dart';
import 'registration_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool check = false;
  bool _obscureText = true;
  bool _isChecked = false;
  bool _loading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkKeepLoggedInStatus();
  }

  Future<void> _checkKeepLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;

    if (keepLoggedIn) {
      String userId = prefs.getString('uid') ?? '';
      if (userId.isNotEmpty) {
        redirectPage();
      }
    }
  }

  void redirectPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashBoard()),
    );
  }

  Future<void> saveUserInfoToLocalDatabase(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', userId);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );
        if (userCredential.user != null) {
          final String userId = userCredential.user!.uid;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('keepLoggedIn', _isChecked);
          bool isUser = await isUserInUsersCollection(userId);
          if (isUser) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard(),));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChildDashBoard()));
          }
        }
      } catch (e) {
        String errorMessage = 'Login failed';

        if (e is FirebaseAuthException) {
          errorMessage = e.code;
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<bool> isUserInUsersCollection(String userId) async {
    // Assuming Firestore is used
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'assets/login.jpg',
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                left: 90,
                child: ClipOval(
                  child: Image.asset(
                    'assets/Logo.png',
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25.0,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Icon(Icons.lock),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: TextFormField(
                    controller: _passController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25.0,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(31, 121, 120, 120),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: InkWell(
                        onTap: _togglePasswordVisibility,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          const Text('Keep Me Logged In')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _loading
                            ? const Center(
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator()),
                              )
                            : ElevatedButton(
                                onPressed: () => _login(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 30, 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20, color: AppColors.white),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
