import 'package:flutter/material.dart';

class WorkoutPlan_Screen extends StatefulWidget {
  const WorkoutPlan_Screen(
      {super.key, required this.SelectedWorkoutPlan, required this.onChanged});

  final String? SelectedWorkoutPlan;
  final ValueChanged<String?>? onChanged;

  @override
  State<WorkoutPlan_Screen> createState() => _WorkoutPlan_ScreenState();
}

class _WorkoutPlan_ScreenState extends State<WorkoutPlan_Screen> {
  String? SelectedWorkoutPlan;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'wrokout plan is required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Select Workout plan',
            labelStyle: TextStyle(fontFamily: 'JacquesFracois', fontSize: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        value: widget.SelectedWorkoutPlan,
        icon: Icon(Icons.arrow_drop_down),
        style: TextStyle(color: Colors.deepPurple),
        onChanged: widget.onChanged,
        items: <String>['Gym Exercise', 'Home Exercise', 'Stretches']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}
