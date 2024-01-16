import 'dart:io';

import 'package:fittrack/admin_screens/admin_widgets/category_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/item_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemdemo_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemname_field.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutlevel_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutplan_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/description_widget.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AdminPanel_Screen extends StatefulWidget {
  const AdminPanel_Screen({Key? key}) : super(key: key);

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
                      Item_Image_Screen(fitnessItemImage: fitnessItemImage),
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
                      Item_Demo_Image(
                          fitnessItemDemoImage: fitnessItemDemoImage),
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
                      ItemName_Screen(ItemNameController: ItemNameController),
                      SizedBox(
                        height: 20,
                      ),
                      WorkoutLevel_Screen(
                        selectedWorkoutLevel: selectedWorkoutLevel,
                        onChanged: (newValue) {
                          setState(() {
                            selectedWorkoutLevel = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Category_Screen(
                        SelectedCategory: SelectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            SelectedCategory = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WorkoutPlan_Screen(
                        SelectedWorkoutPlan: SelectedWorkoutPlan,
                        onChanged: (newValue) {
                          setState(() {
                            SelectedWorkoutPlan = newValue;
                          });
                        },
                      ),
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
                      DescriptionField_Screen(
                          DescriptionController: DescriptionController),
                      SizedBox(
                        height: 20,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                            onPressed: () async {
                              saveToDatabase();

                              print(
                                  'item image:{$fitnessItemImagePathController.text}');
                              print(
                                  'item demo image:{$fitnessItemDemoImagePathController.text}');
                              print(" Name is  :{$ItemNameController.text}");
                              print(" Level is  :{$selectedWorkoutLevel }");
                              print(" category is  :{$SelectedCategory}");
                              print(" plan is  :{$SelectedWorkoutPlan}");
                              print(DescriptionController.text);
                              Navigator.pop(context);

                              if (fitnessItemImage != null) {
                              } else {
                                setState(() {
                                  if (fitnessItemImage == null) {
                                    isItemImageSelected = false;
                                  } else if (fitnessItemDemoImage == null) {}
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
        isItemDemoImageSelected = true;
      }
    });
  }

  void removeImageErroMessage() {
    setState(() {
      isItemImageSelected = true;
      isItemDemoImageSelected = true;
    });
  }

  void saveToDatabase() async {
    final data = ItemsModal(
        fitnessItemImage: fitnessItemImagePathController.text,
        fitnessItemDemoImage: fitnessItemDemoImagePathController.text,
        itemName: ItemNameController.text,
        SelectedWorkoutLevel: selectedWorkoutLevel ?? '',
        SelectedCategory: SelectedCategory ?? '',
        SelctedWorkoutPlan: SelectedWorkoutPlan ?? '',
        Description: DescriptionController.text);

    // Open Hive box
    var box = await Hive.openBox<ItemsModal>('items');
    // Save data to box
    await box.add(data);

    // Close the box to release resources
    // await box.close();
    print(box);
  }
}
