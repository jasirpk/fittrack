import 'package:fittrack/home_screens/searchitems.dart';
import 'package:flutter/material.dart';

class Searchwidget_Screen extends StatelessWidget {
  const Searchwidget_Screen({
    super.key,
    required this.exercise,
  });

  final Map<String, dynamic> exercise;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => Search_Screen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: Container(
          height: 30,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(exercise['icon'] as IconData),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    exercise['title'] as String,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
