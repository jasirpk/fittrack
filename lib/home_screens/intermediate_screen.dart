import 'package:fittrack/items_screens/abs.dart';
import 'package:fittrack/items_screens/back.dart';
import 'package:fittrack/items_screens/biceps.dart';
import 'package:fittrack/items_screens/buttocks.dart';
import 'package:fittrack/items_screens/calf.dart';
import 'package:fittrack/items_screens/chest.dart';
import 'package:fittrack/items_screens/forearm.dart';
import 'package:fittrack/items_screens/legs.dart';
import 'package:fittrack/items_screens/shoulder.dart';
import 'package:fittrack/items_screens/triceps.dart';
import 'package:flutter/material.dart';

class intermediate_Screen extends StatefulWidget {
  const intermediate_Screen({super.key});

  @override
  State<intermediate_Screen> createState() => _intermediate_ScreenState();
}

class _intermediate_ScreenState extends State<intermediate_Screen> {
  List<Map<String, dynamic>> catagaries = [
    {
      "image": "assets/images/average-chest-size-men.png",
      "title": "Chest",
    },
    {
      "image":
          "assets/images/mh-exercise-with-weights-royalty-free-image-1567792294.png",
      "title": "Back",
    },
    {
      "image": "assets/images/Hamstrings-Times-Two.jpg",
      "title": "Buttocks",
    },
    {
      "image": "assets/images/shutterstock_749160127_1000x.jpg",
      "title": "Legs",
    },
    {
      "image":
          "assets/images/c0c98a4b074fbafba32965fb312846e41fb602ad-1080x540.webp",
      "title": "Triceps",
    },
    {
      "image": "assets/images/abs-muscular-muscle-ripped-main.jpg",
      "title": "Abs",
    },
    {
      "image": "assets/images/Muscular-Man-Chained.jpg",
      "title": "Forearm",
    },
    {
      "image":
          "assets/images/360_F_502926966_riOCh73mHgYUHnNqfz7hxJrxjcHnjC7K.jpg",
      "title": "Calf",
    },
    {
      "image": "assets/images/shoulder-workouts-featured.jpg",
      "title": "Shoulder",
    },
    {
      "image":
          "assets/images/Bald-Muscular-Body-Builder-Flexing-His-Biceps.jpg",
      "title": "Biceps",
    },
  ];
  void navigateToCategoryScreen(String selectedCategory) {
    // Convert the selected category to uppercase for case-insensitive comparison
    selectedCategory = selectedCategory.toUpperCase();

    // Map each category title to a specific screen
    Map<String, Widget> categoryScreens = {
      "CHEST": Chest_Screen(selectedCategory: selectedCategory),
      "BACK": BackItem_Screen(selectedCategory: selectedCategory),
      "BUTTOCKS": ButtocksItem_Screen(selectedCategory: selectedCategory),
      "LEGS": LegsItem_Screen(selectedCategory: selectedCategory),
      "TRICEPS": TricepsItem_Screen(selectedCategory: selectedCategory),
      "ABS": AbsItem_Screen(selectedCategory: selectedCategory),
      "FOREARM": ForearmItem_Screen(selectedCategory: selectedCategory),
      "CALF": CalfItem_Screen(selectedCategory: selectedCategory),
      "SHOULDER": ShoulderItem_Screen(selectedCategory: selectedCategory),
      "BICEPS": BicepsItem_Screen(selectedCategory: selectedCategory),
    };

    // Get the corresponding screen for the selected category
    Widget? categoryScreen = categoryScreens[selectedCategory];

    if (categoryScreen != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          return categoryScreen;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
              elevation: 0,
              child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/stretching-man-GettyImages-654424976.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('STRETCHES',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "JacquesFracois"))
                          ]))))),
      Expanded(
          child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10),
                  itemCount: catagaries.length,
                  itemBuilder: (context, index) {
                    final catagarie = catagaries[index];
                    return GestureDetector(
                      onTap: () {
                        navigateToCategoryScreen(catagarie['title']);
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(catagarie['image']),
                                    fit: BoxFit.cover),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(catagarie['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            fontFamily: "JacquesFracois"))
                                  ]))),
                    );
                  })))
    ]);
  }
}
