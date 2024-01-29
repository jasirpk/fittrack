import 'dart:io';

import 'package:fittrack/admin_screens/admin_widgets/category_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/item_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemdemo_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemname_field.dart';
import 'package:fittrack/admin_screens/navigaiton.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutlevel_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutplan_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/description_widget.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AdminPanel_Screen extends StatefulWidget {
  final String? selectedCategory;

  const AdminPanel_Screen({super.key, required this.selectedCategory});
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
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
                      GestureDetector(
                          onTap: () {
                            pickImageFromGallery('fitnessItem');
                          },
                          child: Item_Image_Screen(
                              fitnessItemImage: fitnessItemImage)),
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
                      GestureDetector(
                        onTap: () {
                          pickImageFromGallery('fitnessItemDemo');
                        },
                        child: Item_Demo_Image(
                            fitnessItemDemoImage: fitnessItemDemoImage),
                      ),
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
                        onChanged: (String? newValue) {
                          setState(() {
                            SelectedCategory = newValue!;
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
                              if (formKey.currentState!.validate()) {
                                if (fitnessItemDemoImage != null) {
                                  saveToDatabase();
                                } else {
                                  setState(() {
                                    isItemDemoImageSelected = false;
                                  });
                                }
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
      isItemDemoImageSelected = false;
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

  void saveToDatabase() async {
    final data = ItemsModal(
      fitnessItemImage: fitnessItemImagePathController.text.toString(),
      fitnessItemDemoImage: fitnessItemDemoImagePathController.text.toString(),
      itemName: ItemNameController.text.toString(),
      SelectedWorkoutLevel: selectedWorkoutLevel.toString(),
      SelectedCategory: SelectedCategory.toString(),
      SelctedWorkoutPlan: SelectedWorkoutPlan.toString(),
      Description: DescriptionController.text.toString(),
      isFavorite: false,
    );

    // Open Hive box
    var box = await Hive.openBox<ItemsModal>('items');
    // Save data to box
    await box.add(data);

    print(box);
    NavigationUtils.navigateToScreen(context, SelectedCategory.toString());
  }
}
