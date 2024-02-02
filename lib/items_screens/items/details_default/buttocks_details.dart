import 'package:fittrack/items_screens/variables.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Buttocks_Details_Screen extends StatefulWidget {
  const Buttocks_Details_Screen({super.key});

  @override
  State<Buttocks_Details_Screen> createState() =>
      _Buttocks_Details_ScreenState();
}

class _Buttocks_Details_ScreenState extends State<Buttocks_Details_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'One Leg Cable Kickback',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/images/cable-kickback.gif'),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(buttocks),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              Text(
                '30 Days Workout Diet Plan',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                    fontSize: 20),
              ),
              Text(
                'People also Search this ',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                    fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  // ignore: deprecated_member_use
                  launch(
                      'https://www.mountsinai.org/files/MSHealth/Assets/HS/MonthlyMealPlan_Brochure_Rev24.pdf');
                },
                child: Text(
                  'Click this :',
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/qrcode_www.mountsinai.org.png'),
                        fit: BoxFit.cover)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
