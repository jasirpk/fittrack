import 'package:flutter/material.dart';

class DescriptionField_Screen extends StatelessWidget {
  const DescriptionField_Screen({
    super.key,
    required this.DescriptionController,
  });

  final TextEditingController DescriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Description is required';
        }
        return null;
      },
      controller: DescriptionController,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: TextStyle(fontFamily: 'JacquesFracois', fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
