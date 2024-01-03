import 'package:fittrack/screenshome/biginnerscreen.dart';
import 'package:fittrack/screenshome/intermediatescreen.dart';
import 'package:fittrack/screenshome/navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> categories = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Navbar(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Muscle Groups',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Beginner',
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                ),
                Tab(
                  child: Text(
                    'Intermediate',
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Beginner Tab
            Biginner_Screen(),

            // Content for Intermediate Tab
            intermediate_Screen(),
          ],
        ),
      ),
    );
  }
}
