import 'package:fittrack/admin_screens/login_admin.dart';
import 'package:flutter/material.dart';

class AppbarItems_Screen extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (ctx) {
                                return Admin_Login();
                              }), (route) => false);
                            },
                            child: Text('Signout')),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.logout))
      ],
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      title: Text(
        'Added Items',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
