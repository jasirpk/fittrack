import 'dart:io';

import 'package:fittrack/admin_screens/admin_panel.dart';
import 'package:fittrack/admin_screens/admin_widgets/appbar.dart';
import 'package:fittrack/admin_screens/login_admin.dart';
import 'package:fittrack/admin_screens/update_item.dart';
import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Create_ItemsScreen extends StatefulWidget {
  @override
  State<Create_ItemsScreen> createState() => _Create_ItemsScreenState();
}

class _Create_ItemsScreenState extends State<Create_ItemsScreen> {
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
    return SafeArea(
        child: Scaffold(
            appBar: AppbarItems_Screen(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      AdminPanel_Screen(selectedCategory: SelectedCategory),
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
                  var data = box.values.toList().cast<ItemsModal>();
                  if (data.isEmpty) {
                    return Center(
                      child: Text('No Data'),
                    );
                  } else
                    return Container(
                      child: GridView.builder(
                          itemCount: box.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                          itemBuilder: (Context, index) {
                            return GestureDetector(
                                onTap: () {
                                  editDialog(
                                      data[index],
                                      data[index].fitnessItemImage.trim(),
                                      data[index].fitnessItemDemoImage.trim(),
                                      data[index].itemName.toString(),
                                      data[index]
                                          .SelectedWorkoutLevel
                                          .toString(),
                                      data[index].SelectedCategory.toString(),
                                      data[index].SelctedWorkoutPlan.toString(),
                                      data[index].Description.toString());
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(    
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: FileImage(File(data[index]
                                                  .fitnessItemImage
                                                  .toString())),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Text(
                                                            data[index]
                                                                .SelectedCategory
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1,
                                                                fontFamily:
                                                                    "JacquesFracois"))),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                  content: Text(
                                                                      'Are you sure you want to Delete?'),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'Cancel')),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          deleteItem(
                                                                              data[index]);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            'Delete'))
                                                                  ]);
                                                            });
                                                      },
                                                      icon: Icon(Icons.delete),
                                                      color: Colors.red,
                                                    )
                                                  ],
                                                ),
                                                Row(children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          data[index]
                                                              .itemName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing: 1,
                                                              fontFamily:
                                                                  "JacquesFracois")))
                                                ])
                                              ]),
                                        ))));
                          }),
                    );
                })));
  }

  void deleteItem(ItemsModal modalItem) async {
    await modalItem.delete();
  }

  Future<void> editDialog(
      ItemsModal updateModel,
      String fitnessimage,
      String fitnessdeomoimage,
      String itemName,
      String selectedWorkoutlevel,
      String selectedcategory,
      String selectedWorkoutplan,
      String description) async {
    fitnessItemImagePathController.text = fitnessimage;
    fitnessItemDemoImagePathController.text = fitnessdeomoimage;
    ItemNameController.text = itemName;
    selectedWorkoutLevel = selectedWorkoutlevel;
    SelectedCategory = selectedcategory;

    SelectedWorkoutPlan = selectedWorkoutplan;
    DescriptionController.text = description;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UpdateItem_Screen(updateModal: updateModel)),
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

  signout(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => Admin_Login()), (route) => false);
  }
}
