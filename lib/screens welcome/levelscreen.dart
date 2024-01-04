import 'package:fittrack/screenshome/homescreen.dart';
import 'package:flutter/material.dart';

class Level_Screen extends StatefulWidget {
  const Level_Screen({super.key});

  @override
  State<Level_Screen> createState() => _Level_ScreenState();
}

class _Level_ScreenState extends State<Level_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/powerful-fitness-gym-background_849761-28989.jpg',
                ),
                fit: BoxFit.fill),
          ),
          child: Flexible(
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
                              fontFamily: "JacquesFracois"),
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomeScreen()));
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
                            fit: BoxFit.cover),
                      ),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Biginner",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "JacquesFracois",
                                fontSize: 32,
                                fontWeight: FontWeight.w400),
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomeScreen()));
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
                            fit: BoxFit.cover),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "InterMediate",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "JacquesFracois",
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
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
    );
  }
}
