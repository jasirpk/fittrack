import 'package:fittrack/Sqlite/notesmodal.dart';
import 'package:fittrack/Sqlite/sqflite.dart';
import 'package:fittrack/screens%20welcome/feedbackscreen.dart';
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
        ),
      ),
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
                      subtitle: Text(
                        items[index].noteContent,
                        style: TextStyle(
                          fontFamily: " JacquesFracois",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                    'Are you sure you want to Delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await db.deleteNote(items[index].noteId!);

                                      Navigator.of(context).pop();

                                      Future.delayed(
                                          Duration.zero, () => refresh());
                                    },
                                    child: const Text('DELETE'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('CANCEL'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                      onTap: () {
                        setState(() {
                          titleController.text = items[index].noteTitle;
                          FeedbackController.text = items[index].noteContent;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        db
                                            .updateNote(
                                          titleController.text,
                                          FeedbackController.text,
                                          items[index].noteId,
                                        )
                                            .whenComplete(() {
                                          refresh();
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text("Update"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              ],
                              title: Text("Update note"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                        labelText: 'dd-mm-yyyy'),
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
                                        labelText: 'Content'),
                                  ),
                                ],
                              ),
                            );
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
