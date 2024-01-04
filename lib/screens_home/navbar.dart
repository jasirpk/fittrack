import 'package:fittrack/screens_welcome/addnote.dart';
import 'package:fittrack/screens_welcome/login_screen.dart';
import 'package:fittrack/screens_home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    {"icon": Icons.note, "title": "Admin"},
    {"icon": Icons.logout, "title": "SignOut"},
  ];

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
                child: Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          maxRadius: 50,
                        ),
                      ),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Exercises',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    if (index == exercises.length - 6) {
                      return Divider(
                        thickness: 1,
                        // indent: 20,
                        // endIndent: 20,
                      );
                    } else if (index == exercise.length - -4) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      );
                    } else if (index == exercise.length - -5) {
                      return InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return create_note();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOutQuad;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(
                                  milliseconds:
                                      500), // Adjust the duration as needed
                            ),
                          );
                        },
                        child: Padding(
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (index == exercise.length - 2) {
                      return InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return HomeScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOutQuad;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(
                                  milliseconds:
                                      500), // Adjust the duration as needed
                            ),
                          );
                        },
                        child: Padding(
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (index == exercise.length - -8) {
                      return InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return signout(context);
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOutQuad;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(
                                  milliseconds:
                                      500), // Adjust the duration as needed
                            ),
                          );
                        },
                        child: Padding(
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 12, bottom: 12),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Version 5.0',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => LoginScreen()), (route) => false);
  }
}
