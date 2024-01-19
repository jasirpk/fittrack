import 'dart:io';

import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BackItem_Screen extends StatefulWidget {
  final String selectedCategory;

  const BackItem_Screen({super.key, required this.selectedCategory});

  @override
  State<BackItem_Screen> createState() => _BackItem_ScreenState();
}

class _BackItem_ScreenState extends State<BackItem_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            'BACK',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ValueListenableBuilder<Box<ItemsModal>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              var data = box.values
                  .where((item) =>
                      item.SelectedCategory.toString() ==
                      widget.selectedCategory.toString())
                  .toList()
                  .cast<ItemsModal>();
              // var data = box.values.toList().cast<ItemsModal>();
              if (data.isEmpty) {
                return Center(
                  child: Text('No Data'),
                );
              } else {
                print("Widget Category: ${widget.selectedCategory}");

                return GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: 1.5),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: FileImage(File(
                                      data[index].fitnessItemImage.toString())),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].itemName.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontFamily: "JacquesFracois"),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}