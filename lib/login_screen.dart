import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendify/main.dart';
import 'dashboard_screen.dart';
import 'registration_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool check = false;
  bool _obscureText = true;
  bool _isChecked = false;
  bool _loading = false;// boolen variables used

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
    // function is made as async to keep that process on till it gets complete
    //login page is a form . _formKey.currentState!.validate() is used to check if we miss any field. 
    //eg if email field is missed then it appears red in colour.
    
    if (_formKey.currentState!.validate()) {  
      setState(() {
        _loading = true;  //after click on login button that button changes to loading state.
      });
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final UserCredential userCredential =
            await auth.signInWithEmailAndPassword( //signInWithEmailAndPassword attempts to sign in a user with 
            // email and paasword. If successful directs to next page.
          email: _emailController.text.trim(), // keeps email and password to variables
          password: _passController.text.trim(),
        );
        if (userCredential.user != null) { // if user data is not null
          if (_isChecked) { // keeep me login , if the box is ticked
            String userId = userCredential.user?.uid ?? ''; // stores user data to variable userId which is authentication key
            await saveUserInfoToLocalDatabase(userId);// user data get stored to local database
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('keepLoggedIn', true);// saves a data true to prefs
          }
          redirectPage(); // redirect the page 
        }
      } catch (e) {// if login is failed 
        String errorMessage = 'Login failed'; 

        if (e is FirebaseAuthException) {
          errorMessage = e.code;
        }
 
 //a "toast" is a small, unobtrusive message that appears briefly on the screen to provide 
 //feedback to the user. Toast messages are typically used to display information, warnings, 
 //or errors in a non-intrusive manner.
 //Toast messages are commonly used for displaying notifications that don't require user interaction, 
 //such as informing the user that an action was successful or alerting them to an error. 
 //msg: The message you want to display in the toast.
//toastLength: The duration for which the toast should be displayed. It's set to Toast.LENGTH_SHORT,
      // which typically lasts for a short duration.
//gravity: The position where the toast should appear on the screen. Here, it's set to
// ToastGravity.BOTTOM, meaning the toast will appear at the bottom of the screen.
//backgroundColor: The background color of the toast. In this case, it's set to red (Colors.red).
//textColor: The color of the text in the toast. It's set to white 
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,// for showing error msg
        );
      } finally {
        setState(() {
          _loading = false;// no state change to load if login is false; login false then 
          //'login button' stays on screen without cahnging to loading state.
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView( //The body of the scaffold is a ListView widget, which allows for a scrolling list of children.
        children: [
          Stack(//The Stack widget allows you to place widgets on top of each other.
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
                  child: TextFormField(//TextFormField. This widget is commonly
                  // used for text input in Flutter. It's assigned a controller _passController, 
                  //which presumably is a TextEditingController that manages the input value of this field.
                    controller: _passController,
                    obscureText: _obscureText,//The obscureText property is set based on a variable _obscureText, 
                    //which toggles the visibility of the entered text to obscure the password.Hides password
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
                      suffixIcon: InkWell(//The suffixIcon property adds an icon on the right side 
                      //of the input field. It's wrapped in an InkWell widget to make it clickable. 
                      //When clicked, it calls _togglePasswordVisibility method to toggle the visibility of the password.
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
                      // the validator property is used to validate the input value. 
                      //It checks if the value is empty and returns an error message if it is, 
                      //prompting the user to enter a password.
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add more password validation logic if needed
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
                      GestureDetector(// used for detecting gestures like taps,drags ..
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
                      Expanded(//Expanded widget expands to fill the available space along 
                      //the main axis (horizontal in this case) of the Row
                        child: _loading //conditional operator
                        //Inside the Expanded, there's a conditional expression that 
                        //checks the value of the _loading variable.
                            ? const Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator()),
                            )
                            //loading is true, it displays a Center widget containing a circular progress indicator 
                            //If _loading is true, it shows the circular progress indicator, indicating that some asynchronous 
                            //operation (like logging in) is in progress.
                            : ElevatedButton(
                              //If _loading is false, it shows the login button (ElevatedButton). 
                                onPressed: () => _login(),//_login() method which is presumably responsible for handling the login action when the button is pressed.
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
                                      fontSize: 20,
                                      color: AppColors.white),
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
