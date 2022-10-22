
// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';

import '../../user/usermodel.dart';

 
class DBHelperUser {
  static Database? _database;
  static DBHelperUser? _dbHelper;

    static const String DB_Name = 'userauth.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';
 static const String C_fname = 'fname';
  static const String C_lname = 'lname';
  DBHelperUser._createInstance();
  factory DBHelperUser() {
    _dbHelper ??= DBHelperUser._createInstance();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}userauth.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
       db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " $C_fname TEXT, "
        " $C_lname TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");

        

      },
    );

  
    return database;
  }

   Future<int> saveData(Usermodel user) async {
    var dbClient = await database;
    var res = await dbClient.insert(Table_User, user.toMap() );
    return res;
  }

 
  Future<Usermodel?> getLoginUser(String userId, String password) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserID = '$userId' AND "
        "$C_Password = '$password'");

    if (res.isNotEmpty) {
      return Usermodel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(Usermodel user) async {
    var dbClient = await database;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String userId) async {
    var dbClient = await database;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [userId]);
    return res;
  }


 
}
