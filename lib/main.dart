// import 'package:fittrack/Sqlite/Sqflite.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:fittrack/screens_welcome/welcome_screen.dart';
import 'package:fittrack/screens_home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // @override
  // void initState() {
  //   gotonextScreen();
  //   super.initState();
  // }
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    var db = DatabaseHelper();
    // Check if email and password are not null
    if (email != null && password != null) {
      // Perform auto-login using the saved credentials
      // Modify this part based on your authentication logic
      var response = await db.login(
        Users(
          usrName: null,
          usrMail: email,
          usrPassword: password,
          Imagepath: null,
        ),
      );

      if (response == true) {
        await Future.delayed(Duration(seconds: 1));
        // If auto-login successful, navigate to Level_Screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
        return;
      }
    }
    await Future.delayed(Duration(seconds: 3));
    // If no saved credentials or auto-login failed, navigate to AboutScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => AboutScreen(),
      ),
    );
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

  // Future<void> gotonextScreen() async {
  //   AboutScreen();
  //   await Future.delayed(
  //     Duration(seconds: 3),
  //   );

  //   // Navigator.of(context).pushAndRemoveUntil(
  //   //     MaterialPageRoute(builder: (ctx) => Level_Screen()), (route) => false);
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (ctx) {
  //         return AboutScreen();
  //       },
  //     ),
  //   );
  // }
}
