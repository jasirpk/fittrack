import 'dart:io';

import 'package:flutter/material.dart';

class Item_Demo_Image extends StatefulWidget {
  Item_Demo_Image({
    super.key,
    required this.fitnessItemDemoImage,
  });

  File? fitnessItemDemoImage;

  @override
  State<Item_Demo_Image> createState() => _Item_Demo_ImageState();
}

class _Item_Demo_ImageState extends State<Item_Demo_Image> {
  var fitnessItemDemoImagePathController = TextEditingController();
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
          child: widget.fitnessItemDemoImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    widget.fitnessItemDemoImage!,
                    fit: BoxFit.contain,
                  ),
                )
              : SizedBox(),
        ),
        if (widget.fitnessItemDemoImage != null)
          Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.fitnessItemDemoImage = null;
                    fitnessItemDemoImagePathController.text = '';
                  });
                },
                icon: Icon(Icons.cancel),
              ))
      ],
    );
  }
}
