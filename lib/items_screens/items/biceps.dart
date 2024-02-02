import 'dart:io';

import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:fittrack/items_screens/details.dart';
import 'package:fittrack/items_screens/items/default_items/biceps.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BicepsItem_Screen extends StatefulWidget {
  final String selectedCategory;

  const BicepsItem_Screen({super.key, required this.selectedCategory});

  @override
  State<BicepsItem_Screen> createState() => _BicepsItem_ScreenState();
}

class _BicepsItem_ScreenState extends State<BicepsItem_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            'Biceps',
            style:
                TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1),
          ),
        ),
        body: Column(
          children: [
            Biceps_Default_Item(),
            Expanded(
              child: ValueListenableBuilder<Box<ItemsModal>>(
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
                      return SizedBox();
                      // return Center(
                      //   child: Text('No Exercieses'),
                      // );
                    } else {
                      print("Widget Category: ${widget.selectedCategory}");

                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 1.5),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return Details_Screen(
                                      selectedCategory: data[index].itemName,
                                      itemDemoImagePath:
                                          data[index].fitnessItemDemoImage,
                                      Description: data[index].Description,
                                    );
                                    // Pass the item name to the Details_Screen
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: FileImage(File(data[index]
                                              .fitnessItemImage
                                              .toString())),
                                          fit: BoxFit.cover)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].itemName.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                                fontFamily: "JacquesFracois"),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                data[index].isFavorite =
                                                    !data[index].isFavorite;
                                                data[index].save();
                                              });
                                            },
                                            icon: Icon(
                                                data[index].isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: data[index].isFavorite
                                                    ? Colors.red
                                                    : Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
