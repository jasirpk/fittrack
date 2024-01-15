import 'dart:io';

import 'package:fittrack/admin_screens/admin_panel.dart';
import 'package:flutter/material.dart';

class Create_ItemsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const Create_ItemsScreen({super.key, required this.items});

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
        body: GridView.builder(
          itemCount: widget.items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (Context, index) {
            var currentitem = widget.items[index];
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: FileImage(File(currentitem['itemImage'])),
                        fit: BoxFit.cover),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentitem['itemName'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontFamily: "JacquesFracois"),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
