import 'package:flutter/material.dart';

class Custom_Name_field extends StatelessWidget {
  const Custom_Name_field({
    super.key,
    required this.NameController,
  });

  final TextEditingController NameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "UserName required";
        }
        return null;
      },
      controller: NameController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 120, 117, 117),
          ),
        ),
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
