import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBase {
  static Database? _database;
  static const _dbversion = 1;
  String tablename = 'UniversitiesTable';
  String id = 'id';
  String name = 'name';
  String webpage = 'webpage';
  String country = 'country';

  DBase._privateConstructor();
  static final DBase instance = DBase._privateConstructor();

  Future<Database> get database async => _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'MMR.db';
    return await openDatabase(path, version: _dbversion, onCreate: _createDB);
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tablename($id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$name TEXT NOT NULL, $webpage TEXT NOT NULL, $country TEXT NOT NULL)');
  }

  Future<int> insertUnivesity(int new_id, String new_name, String new_webpage, String new_country) async {
    Database db = await instance.database;
    var result = await db.rawInsert(
        'INSERT INTO $tablename($id,$name,$webpage,$country)'
        ' VALUES(?,?,?,?)',
        [new_id, new_name, new_webpage, new_country]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getUnivesity() async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $tablename ORDER BY $id');
    return result;
  }

  Future<int> deleteUnivesity(int index) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM $tablename WHERE id=$index');
  }
}
