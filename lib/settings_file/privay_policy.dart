import 'package:flutter/material.dart';

class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({super.key});

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  var sizedbox = SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            'Privacy & Policy',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What personal information does FitTrack collect?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "Your privacy matters. We collect email, username, and images from the gallery for personalized experiences. Rest assured, your data is securely managed and protected",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "What general information does FitTrack collect?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "In this app, I only use feedback side for general purpose. I only use the information through analytics to analyze app usage and to improve the apps by provided better features & content.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "Cookies and Other Tracking Devices",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "Our app does not use cookies. We are committed to ensuring the privacy and security of your information. We do not collect any personally identifiable information through cookies. Your privacy is important to us, and we strive to provide a secure and transparent user experience.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "No Third-Party Sharing",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "Your data is not shared with third parties. All information remains within the app and is not transferred to external servers.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "Data Retention",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "Your data is retained on your device for as long as you use the app. You can delete your data within the app at any time.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "App Updates",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "Any updates to the app are designed to enhance your experience and do not compromise the privacy and security of your existing data.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  sizedbox,
                  Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sizedbox,
                  Text(
                    "If you have any questions or concerns about your privacy or data within the app, please contact us at [jasijasu959@gmail.com].",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
