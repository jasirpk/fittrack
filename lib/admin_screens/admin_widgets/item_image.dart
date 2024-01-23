import 'dart:io';

import 'package:flutter/material.dart';

class Item_Image_Screen extends StatefulWidget {
  Item_Image_Screen({
    super.key,
    required this.fitnessItemImage,
  });

  File? fitnessItemImage;

  @override
  State<Item_Image_Screen> createState() => _Item_Image_ScreenState();
}

class _Item_Image_ScreenState extends State<Item_Image_Screen> {
  var fitnessItemImagePathController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/5580709.png')),
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: widget.fitnessItemImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    widget.fitnessItemImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(),
        ),
        if (widget.fitnessItemImage != null)
          Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.fitnessItemImage = null;
                    fitnessItemImagePathController.text = '';
                  });
                },
                icon: Icon(Icons.cancel),
              ))
      ],
    );
  }
}
