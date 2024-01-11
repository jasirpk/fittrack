import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fittrack/Sqlite/itemsmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/screens_Admin/adminpanel_Screen.dart';
import 'package:image_picker/image_picker.dart';

class Create_ItemsScreen extends StatefulWidget {
  const Create_ItemsScreen({Key? key}) : super(key: key);

  @override
  State<Create_ItemsScreen> createState() => _Create_ItemsScreenState();
}

class _Create_ItemsScreenState extends State<Create_ItemsScreen> {
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
    handler = DatabaseHelper();
    items = handler.getItems();
    handler.initDB().whenComplete(() {
      items = getAllItems();
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
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (ctx) => AdminPanel_Screen(),
            ))
                .then((value) {
              if (value) {
                refresh();
              }
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          shape: CircleBorder(),
        ),
        body: FutureBuilder<List<ItemModal>>(
          future: items,
          builder:
              (BuildContext context, AsyncSnapshot<List<ItemModal>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Text('No Data'),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final items = snapshot.data ?? <ItemModal>[];
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(
                            File(items[index].itemImage ??
                                'assets/images/chest_feature.webp'),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          items[index].itemName,
                          style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text('Are you want to delete?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await db.deleteitems(
                                                  items[index].itemId!);
                                              Navigator.of(context).pop();
                                              Future.delayed(Duration.zero,
                                                  () => refresh());
                                            },
                                            child: Text('Delete')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        onTap: () {
                          setState(() {
                            ItemNameController.text = items[index].itemName;
                            fitnessItemImage = File(items[index].itemImage ??
                                'assets/images/chest_feature.webp');

                            fitnessItemDemoImage =
                                File(items[index].itemDemo ?? '');

                            selectedWorkoutLevel = items[index].workoutLevel;
                            SelectedCategory = items[index].category;
                            SelectedWorkoutPlan = items[index].workoutPlan;
                            DescriptionController.text =
                                items[index].description;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: AlertDialog(
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await db
                                                    .updateitems(
                                                        fitnessItemImagePathController
                                                            .text,
                                                        fitnessItemDemoImagePathController
                                                            .text,
                                                        ItemNameController.text,
                                                        selectedWorkoutLevel ??
                                                            '',
                                                        SelectedCategory ?? '',
                                                        SelectedWorkoutPlan ??
                                                            '',
                                                        DescriptionController
                                                            .text,
                                                        items[index].itemId)
                                                    .whenComplete(() {
                                                  refresh();
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Update')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'))
                                        ],
                                      )
                                    ],
                                    title: Text('Update Items'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: formKey,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Fitness Item',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 180,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: fitnessItemImage !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.file(
                                                              fitnessItemImage!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      pickImageFromGallery(
                                                          'fitnessItem');
                                                    },
                                                    icon: Icon(Icons.image),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Fitness Item Demo',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 180,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child:
                                                        fitnessItemDemoImage !=
                                                                null
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child:
                                                                    Image.file(
                                                                  fitnessItemDemoImage!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        pickImageFromGallery(
                                                            'fitnessItemDemo');
                                                      },
                                                      icon: Icon(Icons
                                                          .video_camera_back)),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        ItemNameController,
                                                    decoration: InputDecoration(
                                                        labelText: 'Item name',
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontSize: 12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  DropdownButtonFormField<
                                                      String>(
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Select Workout level',
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontSize: 12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    value: selectedWorkoutLevel,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedWorkoutLevel =
                                                            newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'BEGINNER',
                                                      'INTERMEDIATE'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  DropdownButtonFormField<
                                                      String>(
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Select category',
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontSize: 12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    value: SelectedCategory,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        SelectedCategory =
                                                            newValue;
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
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  DropdownButtonFormField<
                                                      String>(
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Select Workout plan',
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontSize: 12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    value: SelectedWorkoutPlan,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        SelectedWorkoutPlan =
                                                            newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'Gym Exercise',
                                                      'Home Exercise',
                                                      'Stretches'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'How to do?',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'JacquesFracois',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        DescriptionController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Description',
                                                      labelStyle: TextStyle(
                                                          fontFamily:
                                                              'JacquesFracois',
                                                          fontSize: 12),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
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
