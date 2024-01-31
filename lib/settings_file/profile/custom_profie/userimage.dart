import 'dart:io';

import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:flutter/material.dart';

class UserImage_Screen extends StatelessWidget {
  const UserImage_Screen({
    super.key,
    required this.selectedImage,
    required this.userData,
  });

  final File? selectedImage;
  final Users userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(100),
      ),
      child: selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
              ),
            )
          : userData.Imagepath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(userData.Imagepath!),
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(),
    );
  }
}
