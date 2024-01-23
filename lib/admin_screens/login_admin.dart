import 'dart:ui';

import 'package:fittrack/admin_screens/create_Items.dart';
import 'package:fittrack/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin_Login extends StatefulWidget {
  const Admin_Login({super.key});

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {
  bool passwordObscuretext = true;
  void togglePasswordVisibility() {
    setState(() {
      passwordObscuretext = !passwordObscuretext;
    });
  }

  final formkey = GlobalKey<FormState>();
  var UserNameController = TextEditingController();
  var UserPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/284-2840011_person-in-gray-hoodie-using-computer-inside-dark.jpg',
                ),
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Message required";
                          } else if (UserNameController.text.length < 4) {
                            return "Message Length should be more than 4 characters";
                          }
                          return null;
                        },
                        controller: UserNameController,
                        decoration: InputDecoration(
                            labelText: 'Message',
                            labelStyle: TextStyle(
                              color: Colors.white38,
                              fontFamily: 'JacquesFracois',
                            ),
                            prefixIcon: Icon(
                              Icons.admin_panel_settings,
                              color: Colors.white,
                            )),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password required";
                          } else if (UserPasswordController.text.length < 4) {
                            return "password Length should be more than 4 characters";
                          }
                          return null;
                        },
                        controller: UserPasswordController,
                        obscureText: passwordObscuretext,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'JacquesFracois',
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                            icon: Icon(
                              passwordObscuretext
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {}
                            checkLogin(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'JacquesFracois',
                                fontWeight: FontWeight.bold),
                          ))
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

  void checkLogin(BuildContext ctx) async {
    final username = UserNameController.text;
    final password = UserPasswordController.text;
    const Message = 'jasi';
    const scrtCode = '1234';
    if (Message == username && scrtCode == password) {
      // Go to Home
      final sharedprefs = await SharedPreferences.getInstance();
      await sharedprefs.setBool(Save_key, true);

      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx1) {
          return Create_ItemsScreen();
        }),
      );
    } else if (UserNameController.text.isNotEmpty &&
        UserPasswordController.text.isNotEmpty) {
      const errorMessage = 'Message or password does not match';

      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 233, 59, 46),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          content: Text(errorMessage),
        ),
      );
    }
  }
}
