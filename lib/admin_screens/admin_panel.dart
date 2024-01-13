import 'dart:io';

import 'package:fittrack/Sqlite/itemsmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/admin_screens/create_Items.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPanel_Screen extends StatefulWidget {
  const AdminPanel_Screen({super.key});

  @override
  State<AdminPanel_Screen> createState() => _AdminPanel_ScreenState();
}

class _AdminPanel_ScreenState extends State<AdminPanel_Screen> {
  var fitnessItemImagePathController = TextEditingController();
  var fitnessItemDemoImagePathController = TextEditingController();
  var ItemNameController = TextEditingController();
  var DescriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? fitnessItemImage;

  File? fitnessItemDemoImage;
  String? selectedWorkoutLevel;
  String? SelectedCategory;
  String? SelectedWorkoutPlan;
  bool isItemImageSelected = false;
  bool isItemDemoImageSelected = false;
  @override
  void initState() {
    removeImageErroMessage();
    super.initState();
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
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                  ),
                )
              ],
              centerTitle: true,
              title: Text(
                'Admin Panel',
                style: TextStyle(
                    fontFamily: 'JacquesFracois',
                    fontSize: 36,
                    color: Colors.white),
              ),
            )),
        body: SingleChildScrollView(
            child: Padding(
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
                                  letterSpacing: 1,
                                ))
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
                                  child: Image.file(
                                    fitnessItemImage!,
                                    fit: BoxFit.cover,
                                  ))
                              : SizedBox()),
                      IconButton(
                        onPressed: () {
                          pickImageFromGallery('fitnessItem');
                        },
                        icon: Icon(Icons.image),
                      ),
                      if (!isItemImageSelected)
                        Text('Image is required',
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Fitness Item Demo',
                                style: TextStyle(
                                  fontFamily: 'JacquesFracois',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ))
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
                                child: Image.file(
                                  fitnessItemDemoImage!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : SizedBox(),
                      ),
                      IconButton(
                          onPressed: () {
                            pickImageFromGallery('fitnessItemDemo');
                          },
                          icon: Icon(Icons.video_camera_back)),
                      if (!isItemDemoImageSelected)
                        Text('Item Demo Image is required',
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Item name is required';
                          }
                          return null;
                        },
                        controller: ItemNameController,
                        decoration: InputDecoration(
                            labelText: 'Item name',
                            labelStyle: TextStyle(
                                fontFamily: 'JacquesFracois', fontSize: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Workout level is required';
                          }
                          return null;
                        },
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
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'category is required';
                            }
                            return null;
                          },
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
                          }).toList()),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'wrokout plan is required';
                            }
                            return null;
                          },
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                        controller: DescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                              fontFamily: 'JacquesFracois', fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (!isItemImageSelected &&
                                  fitnessItemImage != null) {
                                setState(() {
                                  isItemImageSelected = false;
                                });
                              }
                              if (formKey.currentState!.validate() &&
                                  fitnessItemImage != null) {
                                final db = DatabaseHelper();
                                int result = await db.createitem(ItemModal(
                                  itemImage:
                                      fitnessItemImagePathController.text,
                                  itemDemo:
                                      fitnessItemDemoImagePathController.text,
                                  itemName: ItemNameController.text,
                                  workoutLevel: selectedWorkoutLevel ?? '',
                                  category: SelectedCategory ?? '',
                                  workoutPlan: SelectedWorkoutPlan ?? '',
                                  description: DescriptionController.text,
                                ));

                                if (result > 0) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (ctx) {
                                    return Create_ItemsScreen();
                                  }));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.blue,
                                          content: Text(
                                              "Item Are Successfully Added")));
                                } else {
                                  // Item creation failed
                                  print('Item creation failed');
                                }
                              } else {
                                setState(() {
                                  if (fitnessItemImage == null) {
                                    isItemImageSelected = false;
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            child: Text(
                              'Save Details',
                              style: TextStyle(
                                  fontFamily: 'JacquesFracois',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ])
                    ]))))));
  }

  Future pickImageFromGallery(String imageType) async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnimage == null) {
      isItemImageSelected = false;

      return;
    }

    setState(() {
      if (imageType == 'fitnessItem') {
        fitnessItemImage = File(returnimage.path);
        fitnessItemImagePathController.text = returnimage.path.toString();
        isItemImageSelected = true;
      } else if (imageType == 'fitnessItemDemo') {
        fitnessItemDemoImage = File(returnimage.path);
        fitnessItemDemoImagePathController.text = returnimage.path.toString();
      }
    });
  }

  void removeImageErroMessage() {
    setState(() {
      isItemImageSelected = true;
      isItemDemoImageSelected = true;
    });
  }
}
