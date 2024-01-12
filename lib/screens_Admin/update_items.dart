import 'dart:io';

import 'package:fittrack/Sqlite/itemsmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Update_Screen extends StatefulWidget {
  final ItemModal item;

  const Update_Screen({Key? key, required this.item}) : super(key: key);
  @override
  State<Update_Screen> createState() => _Update_ScreenState();
}

class _Update_ScreenState extends State<Update_Screen> {
  late DatabaseHelper handler;
  late Future<List<ItemModal>> items;
  final db = DatabaseHelper();
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
  void initState() {
    ItemNameController.text = widget.item.itemName;
    fitnessItemImage = File(widget.item.itemImage ?? '');
    fitnessItemDemoImage = File(widget.item.itemDemo ?? '');
    selectedWorkoutLevel = widget.item.workoutLevel;
    SelectedCategory = widget.item.category;
    SelectedWorkoutPlan = widget.item.workoutPlan;
    DescriptionController.text = widget.item.description;
    handler = DatabaseHelper();
    items = handler.getItems();
    handler.initDB().whenComplete(() {
      setState(() {
        items = getAllItems();
      });
    });

    super.initState();
  }

  Future<List<ItemModal>> getAllItems() {
    return handler.getItems();
  }

  // Refresh method
  Future<void> refresh() async {
    setState(() {
      items = getAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.black,
                actions: [
                  Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child:
                          Icon(Icons.admin_panel_settings, color: Colors.white))
                ],
                centerTitle: true,
                title: Text(
                  'Update',
                  style: TextStyle(
                      fontFamily: 'JacquesFracois',
                      fontSize: 36,
                      color: Colors.white),
                ))),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: Container(
                        child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Fitness Item',
                                style: TextStyle(
                                    fontFamily: 'JacquesFracois',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1))
                          ])),
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: fitnessItemImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(fitnessItemImage!,
                                    fit: BoxFit.cover))
                            : SizedBox(),
                      ),
                      IconButton(
                        onPressed: () {
                          pickImageFromGallery('fitnessItem');
                        },
                        icon: Icon(Icons.image),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Fitness Item Demo',
                                style: TextStyle(
                                    fontFamily: 'JacquesFracois',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1))
                          ])),
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: fitnessItemDemoImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(fitnessItemDemoImage!,
                                    fit: BoxFit.cover))
                            : SizedBox(),
                      ),
                      IconButton(
                          onPressed: () {
                            pickImageFromGallery('fitnessItemDemo');
                          },
                          icon: Icon(Icons.video_camera_back)),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: ItemNameController,
                        decoration: InputDecoration(
                            labelText: 'Item name',
                            labelStyle: TextStyle(
                                fontFamily: 'JacquesFracois', fontSize: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: 'Select Workout level',
                            labelStyle: TextStyle(
                                fontFamily: 'JacquesFracois', fontSize: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        value: selectedWorkoutLevel,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWorkoutLevel = newValue;
                          });
                        },
                        items: <String>['BEGINNER', 'INTERMEDIATE']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: 'Select category',
                            labelStyle: TextStyle(
                                fontFamily: 'JacquesFracois', fontSize: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        value: SelectedCategory,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          setState(() {
                            SelectedCategory = newValue;
                          });
                        },
                        items: <String>[
                          'STRETCHES',
                          'CHEST',
                          'BACK',
                          'BUTTOCKS',
                          'LEGS',
                          'TRICEPS',
                          'ABS',
                          'FOREARM',
                          'CALF',
                          'SHOULDER',
                          'BICEPS'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              labelText: 'Select Workout plan',
                              labelStyle: TextStyle(
                                  fontFamily: 'JacquesFracois', fontSize: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          value: SelectedWorkoutPlan,
                          icon: Icon(Icons.arrow_drop_down),
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              SelectedWorkoutPlan = newValue;
                            });
                          },
                          items: <String>[
                            'Gym Exercise',
                            'Home Exercise',
                            'Stretches'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('How to do?',
                                style: TextStyle(
                                  fontFamily: 'JacquesFracois',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ))
                          ])),
                      TextFormField(
                          controller: DescriptionController,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                  fontFamily: 'JacquesFracois', fontSize: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      SizedBox(
                        height: 20,
                      )
                    ])))),
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () async {
                        print("Update button pressed");

                        print("ItemName: ${ItemNameController.text}");
                        print(
                            "fitnessItemImagePath: ${fitnessItemImagePathController.text}");
                        print(
                            "fitnessItemDemoImagePath: ${fitnessItemDemoImagePathController.text}");
                        print("selectedWorkoutLevel: $selectedWorkoutLevel");
                        print("SelectedCategory: $SelectedCategory");
                        print("SelectedWorkoutPlan: $SelectedWorkoutPlan");
                        print("Description: ${DescriptionController.text}");
                        fitnessItemImagePathController.text =
                            fitnessItemImage?.path ?? '';
                        fitnessItemDemoImagePathController.text =
                            fitnessItemDemoImage?.path ?? '';

                        await db
                            .updateitems(
                          fitnessItemImagePathController.text,
                          fitnessItemDemoImagePathController.text,
                          ItemNameController.text,
                          selectedWorkoutLevel ?? '',
                          SelectedCategory ?? '',
                          SelectedWorkoutPlan ?? '',
                          DescriptionController.text,
                          widget.item.itemId,
                        )
                            .whenComplete(() {
                          refresh();
                          Navigator.pop(context);
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: Text(
                        'Update Detials',
                        style: TextStyle(color: Colors.white),
                      )),
                ]))
          ])),
        ));
  }

  Future pickImageFromGallery(String imageType) async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnimage == null) {
      return;
    }
    setState(() {
      if (imageType == 'fitnessItem') {
        fitnessItemImage = File(returnimage.path);
        fitnessItemImagePathController.text = returnimage.path;
      } else if (imageType == 'fitnessItemDemo') {
        fitnessItemDemoImage = File(returnimage.path);
        fitnessItemDemoImagePathController.text = returnimage.path;
      }
    });
  }
}
