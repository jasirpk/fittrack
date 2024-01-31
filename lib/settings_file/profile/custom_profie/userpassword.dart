import 'package:flutter/material.dart';

class UserPassword_Field extends StatelessWidget {
  const UserPassword_Field({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password required";
        } else if (passwordController.text.length < 4) {
          return "Password length should be more than 4 characters";
        }
        return null;
      },
      controller: passwordController,
      decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
