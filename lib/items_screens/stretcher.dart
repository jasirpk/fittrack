import 'package:flutter/material.dart';

class Stretcher_Scree extends StatefulWidget {
  const Stretcher_Scree({super.key});

  @override
  State<Stretcher_Scree> createState() => _Stretcher_ScreeState();
}

class _Stretcher_ScreeState extends State<Stretcher_Scree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Stretcher',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(child: Text('data')),
    );
  }
}
