import 'package:fittrack/Sqlite/notesmodal.dart';
import 'package:fittrack/Sqlite/usermodal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "notes.db";

  //Now we must create our user table into our sqlite db

  String users =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT,Imagepath TEXT, usrName TEXT , usrMail TEXT ,usrPassword TEXT )";
  String notes =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: 5,
      onCreate: (db, version) async {
        await db.execute(users);
        await db.execute(notes);
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

  Future<int> SignUp(Users user) async {
    final Database db = await initDB();
    int result = await db.insert('users', user.toMap());
    print('Sign Up Result:$result');
    return result;
    // return db.insert('users', user.toMap());
  }

//Search Method
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  //CRUD Methods
  // create Note

  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();

    return db.insert('notes', note.toMap());
  }

// create user
  Future<int> createuser(Users user) async {
    final Database db = await initDB();
    return db.insert(users, user.toMap());
  }

  // Get notes
  Future<List<NoteModel>> getNotes() async {
    final db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

// Get users
  Future<List<Users>> getUsers() async {
    final db = await initDB();
    List<Map<String, Object?>> result = await db.query('users');
    return result.map((e) => Users.fromMap(e)).toList();
  }

  //   //Delete Notes
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

// Delete users
  Future<int> deleteuser(int id) async {
    final Database db = await initDB();
    return db.delete('users', where: 'usrid=?', whereArgs: [id]);
  }

  //   //Update Notes
  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
        [title, content, noteId]);
  }

// Ubdate users
  Future<int> updateuser(
      Imagepath, usrName, usrMail, usrPassword, usrId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update users set Imagepath=?,usrName=?,usrMail=?,usrPassword=? where usrid=?',
        [Imagepath, usrName, usrMail, usrPassword, usrId]);
  }

// Update user
//   Future<int> updateuser({
//     required String Imagepath,
//     required String usrName,
//     required String usrMail,
//     required String usrPassword,
//     required String usrId,
//   }) async {
//     final Database db = await initDB();
//     return db.rawUpdate(
//       'update users set Imagepath=?, usrName=?, usrMail=?, usrPassword=? where usrid=?',
//       [Imagepath, usrName, usrMail, usrPassword, usrId],
//     );
//   }
}
