import 'dart:io';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/settings_file/profile/edit_profile.dart';
import 'package:flutter/material.dart';

class profile_Screen extends StatefulWidget {
  const profile_Screen({super.key});

  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen> {
  late DatabaseHelper handler;
  late Future<List<Users>> users;
  @override
  void initState() {
    handler = DatabaseHelper();
    users = handler.getUsers();
    handler.initDB().whenComplete(() {
      users = getAllUsers();
      refresh();
    });
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

  final sizedbox = SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'back',
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
                return Text('Error:${snapshot.error}');
              } else {
                final user = snapshot.data?.firstOrNull;
                final Imagepath = user?.Imagepath ?? '';
                final userName = user?.usrName ?? '';
                final userMail = user?.usrMail ?? '';
                final userpassword = user?.usrPassword ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 28, fontFamily: 'JacquesFracois'),
                      ),
                    ),
                    sizedbox,
                    Padding(
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
                                      border: Border.all(
                                          width: 3, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: CircleAvatar(
                                    maxRadius: 80,
                                    backgroundImage: FileImage(File(Imagepath)),
                                  ),
                                ),
                                sizedbox,
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (ctx) =>
                                                  UpdateProfileScreen(
                                                      userId: user!.usrId!)))
                                          .then((value) => {
                                                if (value != null && value)
                                                  {refresh()}
                                              });
                                    },
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                                Row(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          userName,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                sizedbox,
                                Row(
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          userMail,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                sizedbox,
                                Row(
                                  children: [
                                    Text(
                                      'Password',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          userpassword,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
