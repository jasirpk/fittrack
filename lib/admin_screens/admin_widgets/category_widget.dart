import 'package:flutter/material.dart';

class Category_Screen extends StatefulWidget {
  const Category_Screen({
    super.key,
    required this.SelectedCategory,
  });

  final String? SelectedCategory;

  @override
  State<Category_Screen> createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  String? SelectedCategory;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'category is required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Select category',
            labelStyle: TextStyle(fontFamily: 'JacquesFracois', fontSize: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        value: widget.SelectedCategory,
        icon: Icon(Icons.arrow_drop_down),
        style: TextStyle(color: Colors.deepPurple),
        onChanged: (String? newValue) {
          setState(() {
            SelectedCategory = newValue;
          });
        },
        items: <String>[
          'CHEST',
          'BACK',
          'BUTTOCKS',
          'LEGS',
          'TRICEPS',
          'ABS',
          'FOREARM',
          'CALF',
          'SHOULDER',
          'BICEPS'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}
