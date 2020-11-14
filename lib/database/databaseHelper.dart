import 'package:hisseler/classes/hisseInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database
  String table = 'portfolio';
  String colId = 'id';
  String colKod = 'kod';
  String colDate = 'date'; // millisSinceEpoch
  String colAdet = 'adet'; // INT
  String colAlis = 'alis'; // Double
  String colSatis = 'satis'; // Double
  String colBool = 'isActive';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }
    Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }
    Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'portfolio.db';

    // Open/create the database at a given path
    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

    void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colKod TEXT, $colDate TEXT, $colDate TEXT, $colAdet INTEGER, $colAlis TEXT, $colSatis TEXT, $colBool INTEGER)');
  }

    Future<List<Map<String, dynamic>>> getHisseMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: '$colKod ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertHisse(HisseInfo data) async {
    Database db = await this.database;
    var result = await db.insert(table, data.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateHisse(HisseInfo data) async {
    var db = await this.database;
    var result = await db.update(table, data.toMap(),
        where: '$colId = ?', whereArgs: [data.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteHisse(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $table WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<HisseInfo>> getHisseList() async {
    var hisseMapList = await getHisseMapList(); // Get 'Map List' from database
    int count =
        hisseMapList.length; // Count the number of map entries in db table

    List<HisseInfo> hisseList = List<HisseInfo>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      hisseList.add(HisseInfo.fromMapObject(hisseMapList[i]));
    }

    return hisseList;
  }
}
