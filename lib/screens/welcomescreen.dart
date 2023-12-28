import 'package:fittrack/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/55e83-shutterstock_1922617436.webp'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 500,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Welcome To',
                            style: TextStyle(
                                fontFamily: 'JacquesFracois',
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1),
                          ),
                          Text(
                            'FitTrack Fitness Application',
                            style: TextStyle(
                                fontFamily: 'JacquesFracois',
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1),
                          ),
                          Flexible(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  '"Personalized Workouts\n Will Help You Gain\n Strength, Get In Better\n Shape And Embrace A\n Healthy LifeStayle."',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(350.0, 60.0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return IntroductionScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Get Started',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
