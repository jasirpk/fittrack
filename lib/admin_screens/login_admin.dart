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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'User Can Add New Items :',
                    style:
                        TextStyle(fontSize: 32, fontFamily: "JacquesFracois"),
                  ),
                  SizedBox(height: 40),
                  Column(
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: 'Enter a Text',
                            labelStyle: TextStyle(
                              fontFamily: 'JacquesFracois',
                            ),
                            prefixIcon: Icon(
                              Icons.admin_panel_settings,
                            )),
                      ),
                      SizedBox(
                        height: 40,
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Re-Enter Text',
                          labelStyle: TextStyle(
                            fontFamily: 'JacquesFracois',
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                            icon: Icon(
                              passwordObscuretext
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(250, 60)),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {}
                          checkLogin(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "FitTrack",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: "JacquesFracois",
                        ),
                      )
                    ],
                  )
                ],
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
    // const Message = 'jasi';
    // const scrtCode = '1234';
    if (username == password) {
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
