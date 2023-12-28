import 'package:fittrack/Sqlite/SqfliteModal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "notes.db";

  //Now we must create our user table into our sqlite db

  String users =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT,Imagepath TEXT, usrName TEXT , usrMail TEXT ,usrPassword TEXT )";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute(users);
      },
    );
  }

  //Now we create login and sign up method

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var result = await db.query('users',
        where: 'usrPassword=? AND usrMail=?',
        whereArgs: [user.usrPassword, user.usrMail]);
    print(result);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }
}

  // //Search Method
  // Future<List<NoteModel>> searchNotes(String keyword) async {
  //   final Database db = await initDB();
  //   List<Map<String, Object?>> searchResult = await db
  //       .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
  //   return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  // }

  //CRUD Methods

  //Create Note
//   Future<int> createNote(NoteModel note) async {
//     final Database db = await initDB();
//     return db.insert('notes', note.toMap());
//   }

//   //Get notes
//   Future<List<NoteModel>> getNotes() async {
//     final Database db = await initDB();
//     List<Map<String, Object?>> result = await db.query('notes');
//     return result.map((e) => NoteModel.fromMap(e)).toList();
//   }

//   //Delete Notes
//   Future<int> deleteNote(int id) async {
//     final Database db = await initDB();
//     return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
//   }

//   //Update Notes
//   Future<int> updateNote(title, content, noteId) async {
//     final Database db = await initDB();
//     return db.rawUpdate(
//         'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
//         [title, content, noteId]);
//   }
// }
