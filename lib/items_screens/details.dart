import 'dart:io';

import 'package:flutter/material.dart';

class Details_Screen extends StatefulWidget {
  final String selectedCategory;
  final String itemDemoImagePath;
  final String Description;
  const Details_Screen(
      {super.key,
      required this.selectedCategory,
      required this.itemDemoImagePath,
      required this.Description});

  @override
  State<Details_Screen> createState() => _Details_ScreenState();
}

class _Details_ScreenState extends State<Details_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          widget.selectedCategory,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: FileImage(File(widget.itemDemoImagePath)),
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
                    child: Text(widget.Description),
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
                  fontWeight: FontWeight.w300, letterSpacing: 1, fontSize: 20),
            ),
            Text(
              'People also Search this :',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  fontSize: 16),
            ),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/qrcode_www.prosupps.com.png'),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    );
  }
}
