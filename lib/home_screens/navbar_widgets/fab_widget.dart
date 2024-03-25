import 'package:fittrack/home_screens/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:fittrack/settings_file/reminder.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class BMi_Widget extends StatelessWidget {
  const BMi_Widget({
    super.key,
    required this.animationController,
    required this.animation,
  });

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
            icon: Icons.alarm,
            iconColor: Colors.white,
            title: 'Reminder',
            titleStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontFamily: 'JacquesFracois',
            ),
            bubbleColor: Colors.black,
            onPress: () {
              animationController!.reverse();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyNoteScreen();
              }));
            }),
        Bubble(
            icon: Icons.calculate,
            iconColor: Colors.white,
            title: 'BMI',
            titleStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontFamily: 'JacquesFracois',
            ),
            bubbleColor: Colors.black,
            onPress: () {
              animationController!.reverse();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BMi_Calculate();
              }));
            })
      ],
      onPress: () => animationController!.isCompleted
          ? animationController!.reverse()
          : animationController!.forward(),
      iconColor: Colors.black,
      iconData: Icons.widgets,
      backGroundColor: Colors.white,
      animation: animation!,
    );
  }
}
