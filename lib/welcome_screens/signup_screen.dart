import 'dart:io';
import 'dart:ui';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/Sqlite/Sqflite.dart';
import 'package:fittrack/welcome_screens/level_screen.dart';
import 'package:fittrack/welcome_screens/login_screen.dart';
import 'package:fittrack/welcome_screens/signup_widgets/confirm_password.dart';
import 'package:fittrack/welcome_screens/signup_widgets/email_field_custom.dart';
import 'package:fittrack/welcome_screens/signup_widgets/name_field_custom.dart';
import 'package:fittrack/welcome_screens/signup_widgets/password_field_custom.dart';
import 'package:fittrack/welcome_screens/signup_widgets/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  File? selectedImage;
  String? Imagepath;
  var NameController = TextEditingController();
  var EmailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var ConfirmpasswordController = TextEditingController();
  var imagepathcontroller = TextEditingController();

// bool variable for show and hide password
  bool passwordObscuretext = true;
  bool confirmpasswordobscuretext = true;
  bool isImageSelected = false;

// Creating Globalkey for form
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    removeImageErroMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/Screenshot 2023-12-19 140455.png'),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                      child: SingleChildScrollView(
                          child: Form(
                              key: formkey,
                              child: Column(children: [
                                Text('Register New \n Account',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 42)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Profile_Custom_Screen(
                                            selectedImage: selectedImage),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              pickImageFromGallery();
                                            },
                                            icon: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                if (!isImageSelected)
                                  Text('Image is required',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Custom_Name_field(
                                      NameController: NameController),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Email_field_screen(
                                        EmailAddressController:
                                            EmailAddressController)),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Password_Field_Screen(
                                      passwordController: passwordController,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Confirm_Password_Screen(
                                      ConfirmpasswordController:
                                          ConfirmpasswordController,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          minimumSize: Size(280, 60),
                                        ),
                                        onPressed: () {
                                          if (!isImageSelected &&
                                              selectedImage != null) {
                                            setState(() {
                                              isImageSelected = false;
                                            });
                                          }

                                          if (formkey.currentState!
                                                  .validate() &&
                                              selectedImage != null) {
                                            if (passwordController.text ==
                                                ConfirmpasswordController
                                                    .text) {
                                              print(
                                                  'Stored ${NameController.text}');

                                              final db = DatabaseHelper();
                                              db.SignUp(Users(
                                                usrName: NameController.text,
                                                usrMail:
                                                    EmailAddressController.text,
                                                usrPassword:
                                                    passwordController.text,
                                                Imagepath:
                                                    imagepathcontroller.text,
                                              )).whenComplete(() {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Level_Screen();
                                                }));
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.blue,
                                                      content: Text(
                                                          "You've Successfully Added")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Password does not match.")));
                                            }
                                          } else {
                                            setState(() {
                                              if (selectedImage == null) {
                                                isImageSelected = false;
                                              }
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                              fontSize: 20),
                                        ))),
                                TextButton(
                                    onPressed: () async {},
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Already have account?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                                  return LoginScreen();
                                                }));
                                              },
                                              child: Text('Login',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 176, 6, 219),
                                                  )))
                                        ]))
                              ])))),
                ))));
  }

  Future pickImageFromGallery() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnimage == null) {
      setState(() {
        isImageSelected = false;
      });
      return;
    }
    setState(() {
      selectedImage = File(returnimage.path);
      imagepathcontroller.text = returnimage.path;
      isImageSelected = true;
    });
  }

  void removeImageErroMessage() {
    setState(() {
      isImageSelected = true;
    });
  }
}
