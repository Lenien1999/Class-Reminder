
// ignore_for_file: unused_import, avoid_print, non_constant_identifier_names

 
import 'package:sqflite/sqflite.dart';

import 'timetablemodel.dart';
 
const String tableschedule = 'timetable';
 
class DBHelperttable {
  static Database? _database;
  static DBHelperttable? _dbHelper;

  DBHelperttable._createInstance();
  factory DBHelperttable() {
    _dbHelper ??= DBHelperttable._createInstance();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}timetable.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableschedule ( 
           id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,
             coursecode TEXT, starttime TEXT NOT NULL,day STRING,
             endtime TEXT NOT NULL,remind INTEGER,repeat STRING,color 
             INTEGER)
        ''');

        

      },
    );

  
    return database;
  }

  void inserttimetable(TimeTable ttable)  async {
    var db = await database;
    var result = await db.insert(tableschedule, ttable.tojson());
    print('result : $result');
  }

  Future<List<TimeTable>> Query() async {
    List<TimeTable> ttable = [];

    var db = await database;
    var result = await db.query(tableschedule);
    for (var element in result) {
      var alarmInfo = TimeTable.fromJson(element);
      ttable.add(alarmInfo);
    }

    return ttable;
  }

  Future<int> deletettble(int? id) async {
    var db = await database;
    return await db.delete(tableschedule, where: 'id = ?', whereArgs: [id]);
  }



 
}
