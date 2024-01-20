import 'dart:io';
import 'dart:ui';

import 'package:fittrack/hive/box.dart';
import 'package:fittrack/hive/modal.dart';
import 'package:fittrack/items_screens/details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  var keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white54),
          backgroundColor: Colors.black,
          title: Text(
            'Find what you want?',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Screenshot 2023-12-18 231557.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: keyword,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Search Exercises',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<Box<ItemsModal>>(
                  valueListenable: Boxes.getData().listenable(),
                  builder: (context, box, _) {
                    var data = box.values.toList().cast<ItemsModal>();

                    // Filter the items based on the search keyword
                    var filteredData = data.where((item) {
                      return item.itemName
                          .toLowerCase()
                          .contains(keyword.text.toLowerCase());
                    }).toList();

                    if (filteredData.isEmpty) {
                      return Center(
                        child: Text('No Data'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.file(
                              File(filteredData[index].fitnessItemImage),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              filteredData[index].itemName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Details_Screen(
                                  selectedCategory:
                                      filteredData[index].itemName,
                                  itemDemoImagePath:
                                      filteredData[index].fitnessItemDemoImage,
                                  Description: filteredData[index].Description,
                                ),
                              ));
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
