import 'package:flutter/material.dart';

class UserPassword_Screen extends StatefulWidget {
  const UserPassword_Screen({
    super.key,
    required this.passwordController,
    required this.passwordObscuretext,
  });

  final TextEditingController passwordController;
  final bool passwordObscuretext;

  @override
  State<UserPassword_Screen> createState() => _UserPassword_ScreenState();
}

class _UserPassword_ScreenState extends State<UserPassword_Screen> {
  // bool variable for show and hide password
  bool passwordObscuretext = true;
  void togglePasswordVisibility() {
    setState(() {
      passwordObscuretext = !passwordObscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password required";
        } else if (widget.passwordController.text.length < 4) {
          return "password Length should be more than 4 characters";
        }
        return null;
      },
      controller: widget.passwordController,
      obscureText: passwordObscuretext,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.key,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            togglePasswordVisibility();
          },
          icon: Icon(
            passwordObscuretext ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
