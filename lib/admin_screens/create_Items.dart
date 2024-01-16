import 'dart:io';

import 'package:fittrack/admin_screens/admin_panel.dart';
import 'package:fittrack/admin_screens/update_item.dart';
import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Create_ItemsScreen extends StatefulWidget {
  @override
  State<Create_ItemsScreen> createState() => _Create_ItemsScreenState();
}

class _Create_ItemsScreenState extends State<Create_ItemsScreen> {
  // var fitnessItemImagePathController = TextEditingController();
  // var fitnessItemDemoImagePathController = TextEditingController();
  // var ItemNameController = TextEditingController();
  // var DescriptionController = TextEditingController();
  // File? fitnessItemImage;
  // File? fitnessItemDemoImage;
  // String? selectedWorkoutLevel;
  // String? SelectedCategory;
  // String? SelectedWorkoutPlan;
  // var formKey = GlobalKey<FormState>();

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
        body: ValueListenableBuilder<Box<ItemsModal>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (Context, box, _) {
            return GridView.builder(
              itemCount: box.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (Context, index) {
                var data = box.values.toList().cast<ItemsModal>();
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return UpadatItem_Screen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: FileImage(
                                File(data[index].fitnessItemImage.toString())),
                            fit: BoxFit.cover),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data[index].itemName.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontFamily: "JacquesFracois"),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteItem(data[index]);
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void deleteItem(ItemsModal modalItem) async {
    await modalItem.delete();
  }
}
