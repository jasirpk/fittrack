import 'dart:io';

import 'package:flutter/material.dart';

class Profile_Custom_Screen extends StatelessWidget {
  const Profile_Custom_Screen({
    super.key,
    required this.selectedImage,
  });

  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
            image: AssetImage('assets/images/images.png'), fit: BoxFit.cover),
      ),
      child: selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
              ))
          : SizedBox(),
    );
  }
}
