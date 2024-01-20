import 'dart:io';

import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:fittrack/items_screens/details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Favorite_Screen extends StatefulWidget {
  @override
  State<Favorite_Screen> createState() => _Favorite_ScreenState();
}

class _Favorite_ScreenState extends State<Favorite_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Liked Excercises',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<Box<ItemsModal>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var favoriteItems = box.values
              .where((item) => item.isFavorite)
              .toList()
              .cast<ItemsModal>();

          if (favoriteItems.isEmpty) {
            return Center(
              child: Text('No Favorites'),
            );
          } else {
            return GridView.builder(
              itemCount: favoriteItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1.5),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the details screen for the favorite item
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Details_Screen(
                        selectedCategory: favoriteItems[index].itemName,
                        itemDemoImagePath:
                            favoriteItems[index].fitnessItemDemoImage,
                        Description: favoriteItems[index].Description,
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: FileImage(File(favoriteItems[index]
                                  .fitnessItemImage
                                  .toString())),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favoriteItems[index].itemName.toString(),
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
                                  favoriteItems[index].isFavorite =
                                      !favoriteItems[index].isFavorite;
                                  favoriteItems[index].save();
                                });
                              },
                              icon: Icon(
                                  favoriteItems[index].isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteItems[index].isFavorite
                                      ? Colors.red
                                      : Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
