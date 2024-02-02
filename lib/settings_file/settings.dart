import 'package:fittrack/feedback/addnote.dart';
import 'package:fittrack/settings_file/privay_policy.dart';
import 'package:fittrack/settings_file/profile/profile.dart';
import 'package:fittrack/settings_file/reminder.dart';
import 'package:fittrack/welcome_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings_Home extends StatefulWidget {
  const Settings_Home({super.key});

  @override
  State<Settings_Home> createState() => _Settings_HomeState();
}

class _Settings_HomeState extends State<Settings_Home> {
  List<Map<String, dynamic>> settings = [
    {
      "icon": Icons.person,
      "title": "Profile Info",
      "navigation": Icons.chevron_right,
    },
    {
      "icon": Icons.lock,
      "title": "Privacy Policy",
      "navigation": Icons.chevron_right,
    },
    {
      "icon": Icons.message,
      "title": "Feedback",
      "navigation": Icons.chevron_right,
    },
    {
      "icon": Icons.alarm,
      "title": "Reminders",
      "navigation": Icons.chevron_right,
    },
    {
      "icon": Icons.share,
      "title": "Share this App",
      "navigation": Icons.chevron_right,
    },
    {
      "icon": Icons.logout,
      "title": "SignOut",
      "navigation": Icons.chevron_right,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Expanded(
            child: ListView(
              children: settings.map((General) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: ListTile(
                      minVerticalPadding: 20,
                      iconColor: Colors.black,
                      leading: CircleAvatar(
                        child: Icon(
                          General['icon'],
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.black,
                      ),
                      title: InkWell(
                        splashColor: Colors.blueGrey,
                        child: Text(General['title']),
                      ),
                      onTap: () {
                        handleIconTap(General['title']);
                      },
                      trailing: Icon(General['navigation']),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void handleIconTap(String title) {
    switch (title) {
      case "Profile Info":
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return profile_Screen();
          }),
        );
        break;
      case "Privacy Policy":
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return Privacy_Policy();
          }),
        );
        break;
      case "Feedback":
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return create_note();
          }),
        );
        break;

      case "Reminders":
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return MyNoteScreen();
          }),
        );
        break;
      case "Share this App":
        Share.share("http://schemas.android.com/apk/res/android");
        break;
      case "SignOut":
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to Loagout?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        signout(context);
                      },
                      child: Text('SignOut'))
                ],
              );
            });
    }
  }

  Future<void> signout(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => LoginScreen()), (route) => false);
  }
}
