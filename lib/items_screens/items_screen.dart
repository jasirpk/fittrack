import 'dart:io';

import 'package:flutter/material.dart';

class Items_Screen extends StatefulWidget {
  final String title;
  final String imagePath;

  const Items_Screen({super.key, required this.title, required this.imagePath});

  @override
  State<Items_Screen> createState() => _Items_ScreenState();
}

class _Items_ScreenState extends State<Items_Screen> {
  File? fitnessItemImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SizedBox()),
    );
  }
}
