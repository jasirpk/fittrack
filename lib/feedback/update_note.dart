import 'dart:ui';

import 'package:fittrack/Sqlite/Sqflite.dart';
import 'package:fittrack/Sqlite/notesmodal.dart';
import 'package:fittrack/feedback/addnote.dart';
import 'package:flutter/material.dart';

class UpdateNoteScreen extends StatefulWidget {
  final String title;
  final String content;
  final noteId;
  UpdateNoteScreen(
      {required this.title, required this.content, required this.noteId});

  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();
  @override
  void initState() {
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
    handler = DatabaseHelper();
    notes = handler.getNotes();
    handler.initDB().whenComplete(() {
      notes = getAllNotes();
    });
    super.initState();
  }

  Future<List<NoteModel>> getAllNotes() {
    return handler.getNotes();
  }

//Refresh method
  Future<void> refresh() async {
    setState(() {
      notes = getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/chest_feature.webp'),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Text("Update note"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    labelText: 'dd-mm-yyyy',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Content',
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      db
                          .updateNote(
                        titleController.text,
                        contentController.text,
                        widget.noteId,
                      )
                          .whenComplete(() {
                        refresh();
                        Navigator.of(context)
                            .pop(MaterialPageRoute(builder: (context) {
                          return create_note();
                        }));
                      });
                    },
                    child: Text("Update"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
