import 'dart:io';

import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/home_screens/navbar_widgets/admin_custom.dart';
import 'package:fittrack/home_screens/navbar_widgets/favorite.dart';
import 'package:fittrack/home_screens/navbar_widgets/feedback_custom.dart';
import 'package:fittrack/home_screens/navbar_widgets/home_custom.dart';
import 'package:fittrack/home_screens/navbar_widgets/search_custom.dart';
import 'package:fittrack/home_screens/navbar_widgets/signout_custom.dart';
import 'package:fittrack/home_screens/navbar_widgets/stretcher_custom.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<Map<String, dynamic>> exercises = [
    {"icon": Icons.fitness_center, "title": "All Exercises"},
    {"icon": Icons.home_filled, "title": "Home Exercise"},
    {"icon": Icons.sports_gymnastics, "title": "Stretches"},
    {"icon": Icons.favorite_sharp, "title": "Liked Exercises"},
    {"icon": Icons.search, "title": "Search Exercises"},
    {"icon": Icons.search, "title": "Search Exercises"},
    {"icon": Icons.search, "title": "Search Exercises"},
    {"icon": Icons.message, "title": "Feedback"},
    {"icon": Icons.settings, "title": "Settings"},
    {"icon": Icons.admin_panel_settings, "title": "Admin"},
    {"icon": Icons.logout, "title": "SignOut"},
  ];
  late DatabaseHelper handler;
  late Future<List<Users>> users;
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Colors.white10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 160,
                  decoration: BoxDecoration(color: Colors.red),
                  child: FutureBuilder<List<Users>>(
                      future: users,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error:${snapshot.error}');
                        } else {
                          final user = snapshot.data?.firstOrNull;
                          final userName = user?.usrName ?? '';
                          final imagepath = user?.Imagepath ?? '';

                          return Row(children: [
                            Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipOval(
                                        child: CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage:
                                          FileImage(File(imagepath)),
                                    )))),
                            Text(
                              userName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ]);
                        }
                      })),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Exercises',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    if (index == exercises.length - 6) {
                      return Divider(
                        thickness: 1,
                      );
                    } else if (index == exercise.length - -4) {
                      return Row(children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ))
                      ]);
                    } else if (index == exercise.length - -5) {
                      return Custom_Feedback(exercise: exercise);
                    } else if (index == exercise.length - 2) {
                      return Custom_Home_Screen(exercise: exercise);
                    } else if (index == exercise.length - -8) {
                      return Custom_SignOut(exercise: exercise);
                    } else if (index == exercise.length - -7) {
                      return Custom_Admin(exercise: exercise);
                    } else if (index == exercise.length - -2) {
                      return Searchwidget_Screen(exercise: exercise);
                    } else if (index == exercise.length - 0) {
                      return Stretcherwidget_Screen(exercise: exercise);
                    } else if (index == exercise.length - -1) {
                      return FavoriteItems_Screen(exercise: exercise);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 12, bottom: 12),
                        child: Container(
                          height: 30,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(exercise['icon'] as IconData),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    exercise['title'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Version 6.0',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
