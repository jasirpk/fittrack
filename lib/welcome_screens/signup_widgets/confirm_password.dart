import 'package:flutter/material.dart';

class Confirm_Password_Screen extends StatefulWidget {
  const Confirm_Password_Screen({
    super.key,
    required this.ConfirmpasswordController,
  });

  final TextEditingController ConfirmpasswordController;

  @override
  State<Confirm_Password_Screen> createState() =>
      _Confirm_Password_ScreenState();
}

class _Confirm_Password_ScreenState extends State<Confirm_Password_Screen> {
  bool obscureText = true;
// Method to toggle confirm password visiblitu
  void toggleConfirmPasswordVisibility() {
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
          return "Password Does Not Match";
        }
        return null;
      },
      controller: widget.ConfirmpasswordController,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            toggleConfirmPasswordVisibility();
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
            borderSide: BorderSide(color: Color.fromARGB(255, 120, 117, 117))),
        labelText: ' Confirm Password',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
