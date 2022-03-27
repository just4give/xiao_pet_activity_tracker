import 'dart:convert';
import 'dart:math';

import 'package:pet_activity_tracker/db/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  late Database db;

  Future<Database> open(String path) async {
    db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              var batch = db.batch();
              _createTablesV1(batch);
              _insertWeeklyData(batch);
              await batch.commit();
            },
            onDowngrade: onDatabaseDowngradeDelete));
    return db;
  }

  Future<DailyLog?> getDailyLog(int id) async {
    List<Map<String, Object?>> maps =
        await db.query("DailyLog", where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return DailyLog.fromMap(maps.first);
    }
    return null;
  }

  Future<DailyLog> insertDailyLog(DailyLog dl) async {
    dl.id = await db.insert("DailyLog", dl.toMap());
    return dl;
  }

  Future<int> updateDailyLog(DailyLog dl) async {
    return await db
        .update("DailyLog", dl.toMap(), where: 'id = ?', whereArgs: [dl.id]);
  }

  Future<int> updateWeeklyLog(WeeklyLog wl) async {
    return await db.rawUpdate(
        'UPDATE WeeklyLog SET log = ? WHERE day = ?', [wl.log, wl.day]);
  }

  /// Create tables
  void _createTablesV1(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS WeeklyLog');
    batch.execute('''CREATE TABLE WeeklyLog (
    day TEXT PRIMARY KEY,
    seq INTEGER ,
    log TEXT
    )''');
    batch.execute('DROP TABLE IF EXISTS DailyLog');
    batch.execute('''CREATE TABLE DailyLog (
    id INTEGER PRIMARY KEY,
    day TEXT,
    ts INTEGER,
    ttl INTEGER,
    series TEXT,
    log TEXT
    )''');
  }

  void _insertWeeklyData(Batch batch) {
    //final _random = Random();

    List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    for (var day in weekDays) {
      batch.insert('WeeklyLog', {
        'seq': 1,
        'day': day,
        'log': json.encode({'rest': 0, 'walk': 0, 'run': 0, 'stair': 0})
      });
    }
  }
}
