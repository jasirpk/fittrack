import 'dart:ui';

import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/welcome_screens/level_screen.dart';
import 'package:fittrack/Sqlite/Sqflite.dart';
import 'package:fittrack/welcome_screens/login_widgets/usermail.dart';
import 'package:fittrack/welcome_screens/login_widgets/userpassword.dart';
import 'package:fittrack/welcome_screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var NameController = null;
  var EmailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var imagepathcontroller = null;

// bool variable for show and hide password
  bool passwordObscuretext = true;

// Creating Globalkey for form
  final formkey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  bool isLogintrue = false;

  after() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', EmailAddressController.text);
    prefs.setString('password', passwordController.text);
    var response = await db.login(
      Users(
          usrName: null,
          usrMail: EmailAddressController.text,
          usrPassword: passwordController.text,
          Imagepath: null),
    );
    if (response == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("personal Detials Added Succesfully")));
      print('It is worked');
      //if login is correct, then goto next screen
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
        return Level_Screen();
      }), (route) => false);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Level_Screen()));
    } else {
      print('It is not worked');
      // if not ,true the correct then show the error message
      setState(() {
        isLogintrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/Screenshot 2023-12-19 140455.png'),
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Text('Start With Good\n Confidence',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 48)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UserMail_Screen(
                            EmailAddressController: EmailAddressController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UserPassword_Screen(
                            passwordController: passwordController,
                            passwordObscuretext: passwordObscuretext),
                      ),
                      if (isLogintrue)
                        Text(
                          'EmailAddress or PassWord is Incorrect',
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        SizedBox(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 176, 6, 219),
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            after();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 1),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) {
                                      return SignUp_Screen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
