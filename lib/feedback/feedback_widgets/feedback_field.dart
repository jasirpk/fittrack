import 'package:flutter/material.dart';

class FeedbackField_Screen extends StatelessWidget {
  const FeedbackField_Screen({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.FeedbackController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController FeedbackController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            enabled: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return "Title is required";
              }
              return null;
            },
            controller: titleController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText: 'dd-mm-yyyy',
                labelStyle: TextStyle(fontSize: 12)),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return "Content Required";
              }
              return null;
            },
            controller: FeedbackController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description),
                labelText: 'How was this day?',
                labelStyle: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
