import 'package:fittrack/items_screens/items/details_default/chest_details.dart';
import 'package:flutter/material.dart';

class Chest_Default_Item extends StatelessWidget {
  const Chest_Default_Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return Chest_Details_Default();
          }));
        },
        child: Container(
          height: 230,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.13),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Bench-Press-tutorial_chest-1000x600.jpeg'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Incline Press',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontFamily: "JacquesFracois"),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
