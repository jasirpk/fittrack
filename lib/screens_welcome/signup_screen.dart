import 'dart:io';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/Sqlite/Sqflite.dart';
import 'package:fittrack/screens_welcome/level_screen.dart';
import 'package:fittrack/screens_welcome/login_screen.dart';
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
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text('Register New \n Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 42)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/images.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox()),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                    if (!isImageSelected)
                      Text(
                        'Image is required',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "UserName required";
                          }
                          return null;
                        },
                        controller: NameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 120, 117, 117)),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Address Required';
                          }
                          bool emailvalid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailvalid) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                        controller: EmailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 120, 117, 117)),
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password required";
                          } else if (passwordController.text.length < 4) {
                            return "password Length should be more than 4 characters";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: passwordObscuretext,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObscuretext = !passwordObscuretext;
                              });
                            },
                            icon: Icon(
                              passwordObscuretext
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 120, 117, 117)),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Does Not Match";
                          }
                          return null;
                        },
                        controller: ConfirmpasswordController,
                        obscureText: confirmpasswordobscuretext,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmpasswordobscuretext =
                                    !confirmpasswordobscuretext;
                              });
                            },
                            icon: Icon(
                              confirmpasswordobscuretext
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 120, 117, 117)),
                          ),
                          labelText: ' Confirm Password',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(280, 60),
                        ),
                        onPressed: () {
                          if (!isImageSelected && selectedImage != null) {
                            setState(() {
                              isImageSelected = false;
                            });
                          }

                          if (formkey.currentState!.validate() &&
                              selectedImage != null) {
                            if (passwordController.text ==
                                ConfirmpasswordController.text) {
                              print('Stored ${NameController.text}');
                              final db = DatabaseHelper();
                              db.SignUp(Users(
                                usrName: NameController.text,
                                usrMail: EmailAddressController.text,
                                usrPassword: passwordController.text,
                                Imagepath: imagepathcontroller.text,
                              )).whenComplete(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Level_Screen();
                                      },
                                    ),
                                  );
                                },
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.blue,
                                      content:
                                          Text("You've Successfully Added")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Password does not match."),
                                ),
                              );
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
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account?',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return LoginScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color.fromARGB(255, 176, 6, 219),
                              ),
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
    );
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
      Imagepath = returnimage.path.toString();
      isImageSelected = true;
    });
  }

  void removeImageErroMessage() {
    setState(() {
      isImageSelected = true;
    });
  }
}
