import 'package:flutter/material.dart';

class UserName_Field extends StatelessWidget {
  const UserName_Field({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Name Required";
        }
        return null;
      },
      controller: nameController,
      decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
