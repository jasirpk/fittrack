import 'dart:ui';

import 'package:fittrack/home_screens/home_screen.dart';
import 'package:flutter/material.dart';

class Level_Screen extends StatelessWidget {
  const Level_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/powerful-fitness-gym-background_849761-28989.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 48),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Your Body Can Do\n It. It's Time To\n Convince Your Mind",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: "JacquesFracois",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => HomeScreen(),
                        ));
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/5-Mandatory-Athletic-Exercises-for-Non-Athletes.jpeg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Beginner",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "JacquesFracois",
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => HomeScreen(),
                        ));
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/48201119-athlete-muscular-bodybuilder-training-in-the-gym-back-training-in-gym.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Intermediate",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "JacquesFracois",
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "FitTrack",
                        style: TextStyle(
                          color: Colors.white54,
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
}
