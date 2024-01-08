import 'package:fittrack/screens_Admin/adminpanel_Screen.dart';
import 'package:flutter/material.dart';

class Create_ItemsScreen extends StatefulWidget {
  const Create_ItemsScreen({super.key});

  @override
  State<Create_ItemsScreen> createState() => _Create_ItemsScreenState();
}

class _Create_ItemsScreenState extends State<Create_ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AdminPanel_Screen(),
            ));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black, // Set the background color
          shape: CircleBorder(),
        ),
        // backgroundColor: Colors.black,
      ),
    );
  }
}
