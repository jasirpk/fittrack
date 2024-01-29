import 'dart:io';

import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/settings_file/profile/profile.dart';
import 'package:flutter/material.dart';

class EditProfile_Screen extends StatefulWidget {
  final String? Imagepath;
  final String? userName;
  final String? userMail;
  final String? userPassword;
  final userId;

  const EditProfile_Screen(
      {super.key,
      required this.Imagepath,
      required this.userName,
      required this.userMail,
      required this.userPassword,
      required this.userId});

  @override
  State<EditProfile_Screen> createState() => _EditProfile_ScreenState();
}

class _EditProfile_ScreenState extends State<EditProfile_Screen> {
  final sizedbox = SizedBox(
    height: 20,
  );
  File? selectedImage;
  late TextEditingController ImagepathController;
  late TextEditingController userNameController;
  late TextEditingController userMailController;
  late TextEditingController userPasswordController;
  late DatabaseHelper handler;
  late Future<List<Users>> users;
  final db = DatabaseHelper();
  @override
  void initState() {
    ImagepathController = TextEditingController(text: widget.Imagepath);
    userNameController = TextEditingController(text: widget.userName);
    userMailController = TextEditingController(text: widget.userMail);
    userPasswordController = TextEditingController(text: widget.userPassword);
    handler = DatabaseHelper();
    users = handler.getUsers();
    handler.initDB().whenComplete(() {
      users = getAllUsers();
    });
    super.initState();
  }

  Future<List<Users>> getAllUsers() {
    return handler.getUsers();
  }

  Future<void> refresh() async {
    setState(() {
      users = getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30)),
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100)),
                      child: CircleAvatar(
                        maxRadius: 80,
                        backgroundImage:
                            FileImage(File(ImagepathController.text)),
                      ),
                    ),
                    TextFormField(
                      controller: userNameController,
                    ),
                    sizedbox,
                    TextFormField(
                      controller: userMailController,
                    ),
                    sizedbox,
                    TextFormField(
                      controller: userPasswordController,
                    ),
                    sizedbox,
                    Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            db
                                .updateuser(
                                    ImagepathController.text,
                                    userNameController.text,
                                    userMailController.text,
                                    userPasswordController.text,
                                    widget.userId)
                                .whenComplete(() {
                              refresh();
                              Navigator.of(context)
                                  .pop(MaterialPageRoute(builder: (context) {
                                return profile_Screen();
                              }));
                            });
                          },
                          child: Text('Update'),
                        ),
                        sizedbox,
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
