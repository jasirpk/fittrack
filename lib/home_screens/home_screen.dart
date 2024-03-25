import 'package:fittrack/home_screens/biginner_screen.dart';
import 'package:fittrack/home_screens/intermediate_screen.dart';
import 'package:fittrack/home_screens/navbar.dart';
import 'package:fittrack/home_screens/navbar_widgets/fab_widget.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> categories = [];

  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 260));
    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeInOut);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: BMi_Widget(
              animationController: animationController, animation: animation),
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
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'JacquesFracois',
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Intermediate',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'JacquesFracois',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // Content
              //for Beginner Tab
              Biginner_Screen(),

              // Content for Intermediate Tab
              intermediate_Screen(),
            ],
          ),
        ),
      ),
    );
  }
}
