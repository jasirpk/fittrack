import 'package:flutter/material.dart';

class Biginner_Screen extends StatefulWidget {
  const Biginner_Screen({super.key});

  @override
  State<Biginner_Screen> createState() => _Biginner_ScreenState();
}

class _Biginner_ScreenState extends State<Biginner_Screen> {
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
      "image": "assets/images/shoulder-workouts-featured.jpg",
      "title": "Shoulder",
    },
    {
      "image":
          "assets/images/Bald-Muscular-Body-Builder-Flexing-His-Biceps.jpg",
      "title": "Biceps",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/istockphoto-679305702-170667a.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'STRUCHERS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: "JacquesFracois"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: catagaries.length,
              itemBuilder: (context, index) {
                final catagarie = catagaries[index];
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          Text(
                            catagarie['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontFamily: "JacquesFracois"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
