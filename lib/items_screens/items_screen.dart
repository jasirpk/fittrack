import 'dart:io';

import 'package:fittrack/Sqlite/itemsmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:flutter/material.dart';

class Items_Screen extends StatefulWidget {
  final String title;
  final String imagePath;

  const Items_Screen({super.key, required this.title, required this.imagePath});

  @override
  State<Items_Screen> createState() => _Items_ScreenState();
}

class _Items_ScreenState extends State<Items_Screen> {
  late DatabaseHelper handler;
  final db = DatabaseHelper();
  File? fitnessItemImage;
  late Future<List<ItemModal>> items;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        // body: Center(
        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image.asset(widget.imagePath),
        //     SizedBox(height: 20),
        //     Text(
        //       'Title: ${widget.title}',
        //       style: TextStyle(fontSize: 20),
        //     )
        //   ],
        // )),
        body: FutureBuilder<List<ItemModal>>(
            future: items,
            builder: (BuildContext context,
                AsyncSnapshot<List<ItemModal>> snapshot) {
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
                      crossAxisCount: 1,
                      // crossAxisSpacing: 8.0,
                      // mainAxisSpacing: 8.0,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: FileImage(
                                    File(items[index].itemImage ?? '')),
                                fit: BoxFit.cover)),
                        child: ListTile(
                            title: Text(items[index].itemName,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.white))),
                      );
                    });
              }
            }),
      ),
    );
  }
}
