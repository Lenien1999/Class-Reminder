
import 'package:classreminderapp/backend/schedule/lecturerSchDbmodel.dart';
import 'package:sqflite/sqflite.dart';

import 'schedulemodel.dart';
const String lecturetable = 'lecschedule';
class DBHelperLecturer {
  static Database? _database;
  static DBHelperLecturer? _dbHelper;

  DBHelperLecturer._createInstance();
  factory DBHelperLecturer() {
    _dbHelper ??= DBHelperLecturer._createInstance();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "lecschedule.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        
        db.execute('''
          create table $lecturetable ( 
           id INTEGER PRIMARY KEY AUTOINCREMENT,course STRING,
             note TEXT, date STRING,starttime TEXT NOT NULL,
             endtime TEXT NOT NULL,signaturer STRING,color 
             INTEGER)
        ''');

      },
    );

  
    return database;
  }


  void insertschedule(LecturerTask task)  async {
    var db = await database;
    var result = await db.insert(lecturetable, task.tojson());
    print('result : $result');
  }

  Future<List<LecturerTask>> QuerySchedule() async {
    List<LecturerTask> task = [];

    var db = await database;
    var result = await db.query(lecturetable);
    for (var element in result) {
      var alarmInfo = LecturerTask.fromJson(element);
      task.add(alarmInfo);
    }

    return task;
  }

  Future<int> deleteSchedule(int? id) async {
    var db = await database;
    return await db.delete(lecturetable, where: 'id = ?', whereArgs: [id]);
  }
}
