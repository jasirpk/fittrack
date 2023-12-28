import 'package:fittrack/screens/welcomescreen.dart';
import 'package:flutter/material.dart';

main() {
  runApp(Fit_Track());
}

class Fit_Track extends StatelessWidget {
  const Fit_Track({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splash_Screen(),
    );
  }
}

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    gotonextScreen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 19, 19, 19),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image:
                  AssetImage('assets/images/Screenshot 2023-12-18 235023.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'STAY & KEEP IT UP',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontFamily: ' JacquesFracois',
                      fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading',
                      style: TextStyle(
                          fontFamily: ' JacquesFracois',
                          color: const Color.fromARGB(255, 213, 201, 201),
                          fontSize: 15),
                    ),
                    SizedBox(width: 10),
                    CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.white12,
                      strokeWidth: 5.0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return AboutScreen();
                            },
                          ),
                        );
                      },
                      child: Image(
                        image: AssetImage(
                          'assets/images/Screenshot 2023-12-18 185831.png',
                        ),
                        fit: BoxFit.cover,
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotonextScreen() async {
    AboutScreen();
    await Future.delayed(
      Duration(seconds: 3),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return AboutScreen();
        },
      ),
    );
  }
}
