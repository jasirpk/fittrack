import 'package:flutter/material.dart';

class ItemName_Screen extends StatelessWidget {
  const ItemName_Screen({
    super.key,
    required this.ItemNameController,
  });

  final TextEditingController ItemNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Item name is required';
        }
        return null;
      },
      controller: ItemNameController,
      decoration: InputDecoration(
        labelText: 'Item name',
        labelStyle: TextStyle(fontFamily: 'JacquesFracois', fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
