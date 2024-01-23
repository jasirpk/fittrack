import 'dart:io';

import 'package:fittrack/admin_screens/admin_widgets/category_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/description_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/item_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemdemo_image.dart';
import 'package:fittrack/admin_screens/admin_widgets/itemname_field.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutlevel_widget.dart';
import 'package:fittrack/admin_screens/admin_widgets/workoutplan_widget.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateItem_Screen extends StatefulWidget {
  final ItemsModal updateModal;

  const UpdateItem_Screen({super.key, required this.updateModal});

  @override
  State<UpdateItem_Screen> createState() => _UpdateItem_ScreenState();
}

class _UpdateItem_ScreenState extends State<UpdateItem_Screen> {
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
    super.initState();

    // Set initial values for controllers and variables
    fitnessItemImagePathController.text = widget.updateModal.fitnessItemImage;
    fitnessItemDemoImagePathController.text =
        widget.updateModal.fitnessItemDemoImage;
    ItemNameController.text = widget.updateModal.itemName;
    selectedWorkoutLevel = widget.updateModal.SelectedWorkoutLevel;
    SelectedCategory = widget.updateModal.SelectedCategory;
    SelectedWorkoutPlan = widget.updateModal.SelctedWorkoutPlan;
    DescriptionController.text = widget.updateModal.Description;

    // If you want to set initial values for images, you can do so here
    fitnessItemImage = File(widget.updateModal.fitnessItemImage);
    fitnessItemDemoImage = File(widget.updateModal.fitnessItemDemoImage);
  }

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
              'Update Side',
              style: TextStyle(
                  fontFamily: 'JacquesFracois',
                  fontSize: 36,
                  color: Colors.white),
            ),
          )),
      body: Container(
          child: SingleChildScrollView(
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (fitnessItemDemoImage != null) {
                                        widget.updateModal.fitnessItemImage =
                                            fitnessItemImagePathController.text
                                                .toString();
                                        widget.updateModal
                                                .fitnessItemDemoImage =
                                            fitnessItemDemoImagePathController
                                                .text
                                                .toString();
                                        widget.updateModal.itemName =
                                            ItemNameController.text.toString();
                                        widget.updateModal
                                                .SelectedWorkoutLevel =
                                            selectedWorkoutLevel ??
                                                ''.toString();
                                        widget.updateModal.SelectedCategory =
                                            SelectedCategory ?? ''.toString();
                                        widget.updateModal.SelctedWorkoutPlan =
                                            SelectedWorkoutPlan ??
                                                ''.toString();
                                        widget.updateModal.Description =
                                            DescriptionController.text
                                                .toString();

                                        // Save the updated model back to Hive
                                        await widget.updateModal.save();
                                        Navigator.pop(context);
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
                      ])))))),
    );
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
}
