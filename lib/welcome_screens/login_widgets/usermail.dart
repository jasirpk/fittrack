import 'package:flutter/material.dart';

class UserMail_Screen extends StatelessWidget {
  const UserMail_Screen({
    super.key,
    required this.EmailAddressController,
  });

  final TextEditingController EmailAddressController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email Address Required';
        }
        bool emailvalid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
        if (!emailvalid) {
          return "Enter Valid Email";
        }
        return null;
      },
      controller: EmailAddressController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'Email Address',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
