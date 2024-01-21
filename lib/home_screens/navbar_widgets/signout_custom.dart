import 'package:fittrack/welcome_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Custom_SignOut extends StatelessWidget {
  Custom_SignOut({
    super.key,
    required this.exercise,
  });

  final Map<String, dynamic> exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => signout(ctx)));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
          child: Container(
            height: 30,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(exercise['icon'] as IconData),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      exercise['title'],
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => LoginScreen()), (route) => false);
  }
}
