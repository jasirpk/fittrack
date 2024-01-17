import 'package:fittrack/Sqlite/notesmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/welcome_screens/feedback_screen.dart';
import 'package:fittrack/welcome_screens/update_note.dart';
import 'package:flutter/material.dart';

class create_note extends StatefulWidget {
  const create_note({super.key});

  @override
  State<create_note> createState() => _create_noteState();
}

class _create_noteState extends State<create_note> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();
  var titleController = TextEditingController();
  var FeedbackController = TextEditingController();

  @override
  void initState() {
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
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            'Feedback Side',
            style: TextStyle(color: Colors.white),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => Feedback_Screen()))
              .then((value) {
            if (value) {
              refresh();
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: Expanded(
        child: FutureBuilder<List<NoteModel>>(
          future: notes,
          builder:
              (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Text('No Data'),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final items = snapshot.data ?? <NoteModel>[];

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        items[index].noteTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: Text(items[index].noteContent,
                          style: TextStyle(
                            fontFamily: " JacquesFracois",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    const Text('Are you sure to want Delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await db.deleteNote(items[index].noteId!);

                                      Navigator.of(context).pop();

                                      Future.delayed(
                                          Duration.zero, () => refresh());
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateNoteScreen(
                                    title: items[index].noteTitle,
                                    content: items[index].noteContent,
                                    noteId: items[index].noteId))).then(
                          (value) {
                            if (value) {
                              refresh();
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
