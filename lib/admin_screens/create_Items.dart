import 'dart:io';

import 'package:fittrack/admin_screens/admin_panel.dart';
import 'package:flutter/material.dart';

class Create_ItemsScreen extends StatefulWidget {
  const Create_ItemsScreen({Key? key}) : super(key: key);

  @override
  State<Create_ItemsScreen> createState() => _Create_ItemsScreenState();
}

class _Create_ItemsScreenState extends State<Create_ItemsScreen> {
  var fitnessItemImagePathController = TextEditingController();
  var fitnessItemDemoImagePathController = TextEditingController();
  var ItemNameController = TextEditingController();
  var DescriptionController = TextEditingController();
  File? fitnessItemImage;
  File? fitnessItemDemoImage;
  String? selectedWorkoutLevel;
  String? SelectedCategory;
  String? SelectedWorkoutPlan;
  var formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            'Create Admin',
            style: TextStyle(color: Colors.white),
          ),
        ),
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
          backgroundColor: Colors.black,
          shape: CircleBorder(),
        ),
        body: SizedBox(),
      ),
    );
  }
}
