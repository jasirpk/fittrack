import 'package:fittrack/Sqlite/notesmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:flutter/material.dart';

class Feedback_Screen extends StatefulWidget {
  const Feedback_Screen({super.key});

  @override
  State<Feedback_Screen> createState() => _Feedback_ScreenState();
}

class _Feedback_ScreenState extends State<Feedback_Screen> {
  DateTime? selectedDate;
  var titleController = TextEditingController();
  var FeedbackController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            '30 days Challenge',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Select the Date',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "JacquesFracois"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(20),
                      elevation: 10,
                      child: Container(
                        height: 350,
                        child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2025),
                          onDateChanged: (date) {
                            setState(() {
                              selectedDate = date;
                              titleController.text = formatDate(selectedDate!);
                            });
                            print('selected Date: $selectedDate');
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'FeedBack',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title is required";
                              }
                              return null;
                            },
                            controller: titleController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range),
                                labelText: 'dd-mm-yyyy',
                                labelStyle: TextStyle(fontSize: 12)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Content Required";
                              }
                              return null;
                            },
                            controller: FeedbackController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.description),
                                labelText: 'How was this day?',
                                labelStyle: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              db
                                  .createNote(NoteModel(
                                      noteTitle: titleController.text,
                                      noteContent: FeedbackController.text,
                                      createdAt:
                                          DateTime.now().toIso8601String()))
                                  .whenComplete(() {
                                Navigator.of(context).pop(true);
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue)),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day} ';
  }
}
