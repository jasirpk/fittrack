import 'package:flutter/material.dart';

class WorkoutLevel_Screen extends StatefulWidget {
  const WorkoutLevel_Screen({
    Key? key,
    required this.selectedWorkoutLevel,
    required this.onChanged,
  }) : super(key: key);

  final String? selectedWorkoutLevel;
  final ValueChanged<String?>? onChanged;

  @override
  State<WorkoutLevel_Screen> createState() => _WorkoutLevel_ScreenState();
}

class _WorkoutLevel_ScreenState extends State<WorkoutLevel_Screen> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Workout level is required';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Select Workout level',
          labelStyle: TextStyle(fontFamily: 'JacquesFracois', fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      value: widget.selectedWorkoutLevel,
      icon: Icon(Icons.arrow_drop_down),
      style: TextStyle(color: Colors.deepPurple),
      onChanged: widget.onChanged, // Use the onChanged directly
      items: <String>['BEGINNER', 'INTERMEDIATE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
