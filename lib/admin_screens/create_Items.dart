import 'dart:io';

import 'package:fittrack/admin_screens/admin_panel.dart';
import 'package:fittrack/admin_screens/update_items.dart';
import 'package:flutter/material.dart';
import 'package:fittrack/Sqlite/itemsmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';

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
                                        content:
                                            Text('Are you want to delete?'),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (Context) =>
                                      Update_Screen(item: items[index]),
                                ));
                          }),
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
}
