import 'dart:io';

import 'package:flutter/material.dart';

class Item_Image_Screen extends StatelessWidget {
  const Item_Image_Screen({
    super.key,
    required this.fitnessItemImage,
  });

  final File? fitnessItemImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: fitnessItemImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                fitnessItemImage!,
                fit: BoxFit.cover,
              ),
            )
          : SizedBox(),
    );
  }
}
