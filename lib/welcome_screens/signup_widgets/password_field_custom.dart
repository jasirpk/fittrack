import 'package:flutter/material.dart';

class Password_Field_Screen extends StatefulWidget {
  const Password_Field_Screen({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<Password_Field_Screen> createState() => _Password_Field_ScreenState();
}

class _Password_Field_ScreenState extends State<Password_Field_Screen> {
  bool obscureText = true;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
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
          return "Password length should be more than 4 characters";
        }
        return null;
      },
      controller: widget.passwordController,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            togglePasswordVisibility();
          },
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        ),
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
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
