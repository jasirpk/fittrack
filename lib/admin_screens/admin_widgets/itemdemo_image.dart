import 'dart:io';

import 'package:flutter/material.dart';

class Item_Demo_Image extends StatelessWidget {
  const Item_Demo_Image({
    super.key,
    required this.fitnessItemDemoImage,
  });

  final File? fitnessItemDemoImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: fitnessItemDemoImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                fitnessItemDemoImage!,
                fit: BoxFit.contain,
              ),
            )
          : SizedBox(),
    );
  }
}
