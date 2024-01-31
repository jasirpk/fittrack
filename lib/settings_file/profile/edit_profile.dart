import 'dart:io';

import 'package:fittrack/settings_file/profile/custom_profie/userimage.dart';
import 'package:fittrack/settings_file/profile/custom_profie/usermail.dart';
import 'package:fittrack/settings_file/profile/custom_profie/username_field.dart';
import 'package:fittrack/settings_file/profile/custom_profie/userpassword.dart';
import 'package:flutter/material.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  final int userId;

  UpdateProfileScreen({required this.userId});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? selectedImage;
  bool isImageSelected = false;
  final formkey = GlobalKey<FormState>();

  String? Imagepath;
  late DatabaseHelper handler;
  late Future<List<Users>> users;
  TextEditingController imagepathcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    users = handler.getUsers();
    handler.initDB().whenComplete(() {
      users = getAllUsers();
    });
    refresh();
    super.initState();
  }

  Future<List<Users>> getAllUsers() {
    return handler.getUsers();
  }

//Refresh method
  Future<void> refresh() async {
    setState(() {
      users = handler.getUsers();
    });
  }

  var sizedbox = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Users> userList = snapshot.data as List<Users>;
              Users userData = userList.first;
              imagepathcontroller.text = userData.Imagepath ?? '';
              nameController.text = userData.usrName ?? '';
              emailController.text = userData.usrMail;
              passwordController.text = userData.usrPassword;

              return Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImageFromGallery();
                            },
                            child: UserImage_Screen(
                                selectedImage: selectedImage,
                                userData: userData),
                          ),
                          if (selectedImage != null)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedImage = null;
                                    imagepathcontroller.text = '';
                                  });
                                },
                                icon: Icon(Icons.cancel),
                              ),
                            ),
                        ],
                      ),
                      sizedbox,
                      UserName_Field(nameController: nameController),
                      sizedbox,
                      UserMail_Field(emailController: emailController),
                      sizedbox,
                      UserPassword_Field(
                          passwordController: passwordController),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(250, 60)),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await updateProfile(widget.userId).then((value) {
                              refresh();
                            });
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> updateProfile(int userId) async {
    String ImagePath = selectedImage != null
        ? selectedImage!.path
        : imagepathcontroller.text.toString();
    String name = nameController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

    int result =
        await handler.updateuser(ImagePath, name, email, password, userId);
    if (result > 0) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("You Updated Successfully")));
    }
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
    });
  }
}
