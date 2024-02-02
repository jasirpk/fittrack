import 'package:fittrack/items_screens/items/details_default/legs_details.dart';
import 'package:flutter/material.dart';

class Legs_Default_Item extends StatelessWidget {
  const Legs_Default_Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return Legs_Details_Screen();
          }));
        },
        child: Container(
          height: 230,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.13),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/shutterstock_430434973_1600x.webp'),
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
                    'Lying Leg Curls',
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
