
// import 'package:sqflite/sqflite.dart';
// const String tableschedule = 'lectureschedule';
// class LecturerDB {

//   static Database? _database;
//   static LecturerDB? _lecturerDB;

//   LecturerDB._createInstance();
//   factory LecturerDB() {
//     _lecturerDB ??= LecturerDB._createInstance();
//     return _lecturerDB!;
//   }

//   Future<Database> get database async {
//     _database ??= await initializeDatabase();
//     return _database!;
//   }

//   Future<Database> initializeDatabase() async {
//     var dir = await getDatabasesPath();
//     var path = dir + "lectureschedule.db";

//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           create table $tableschedule ( 
//            id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,
//              note TEXT, date STRING,starttime STRING,
//              endtime STRING,remind INTEGER,repeat STRING,color 
//              INTEGER)
//         ''');
//       },
//     );

  
//     return database;
//   }

//   void inserttask(Task task)  async {
//     var db = await this.database;
//     var result = await db.insert(tableschedule, task.tojson());
//     print('result : $result');
//   }

//   Future<List<Task>> Query() async {
//     List<Task> _task = [];

//     var db = await this.database;
//     var result = await db.query(tableschedule);
//     result.forEach((element) {
//       var alarmInfo = Task.fromJson(element);
//       _task.add(alarmInfo);
//     });

//     return _task;
//   }

//   Future<int> delete(int? id) async {
//     var db = await this.database;
//     return await db.delete(tableschedule, where: 'id = ?', whereArgs: [id]);
//   }
// }
