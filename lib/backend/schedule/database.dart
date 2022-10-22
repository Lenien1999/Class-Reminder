// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:sqflite/sqflite.dart';

import 'schedulemodel.dart';
const String tableschedule = 'schedule';
const String lecturetable = 'lecschedule';
class DBHelper {
  static Database? _database;
  static DBHelper? _dbHelper;

  DBHelper._createInstance();
  factory DBHelper() {
    _dbHelper ??= DBHelper._createInstance();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}schedule.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableschedule ( 
           id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,
             note TEXT, date STRING,starttime TEXT NOT NULL,
             endtime TEXT NOT NULL,remind INTEGER,repeat STRING,color 
             INTEGER)
        ''');

        

      },
    );

  
    return database;
  }

  void inserttask(Task task)  async {
    var db = await database;
    var result = await db.insert(tableschedule, task.tojson());
    print('result : $result');
  }

  Future<List<Task>> Query() async {
    List<Task> task = [];

    var db = await database;
    var result = await db.query(tableschedule);
    for (var element in result) {
      var alarmInfo = Task.fromJson(element);
      task.add(alarmInfo);
    }

    return task;
  }

  Future<int> delete(int? id) async {
    var db = await database;
    return await db.delete(tableschedule, where: 'id = ?', whereArgs: [id]);
  }



 
}
