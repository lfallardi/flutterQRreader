import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/src/model/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );

  }

  // INSERT
  nuevoScanRaw( ScanModel newScan ) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans ( id, tipo, valor ) "
      "VALUES ( ${newScan.id}, '${newScan.tipo}', '${newScan.valor}' )"
    );

    return res;

  }

  nuevoScan ( ScanModel newScan ) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  // SELECT
  //    SELECT BY ID
  Future<ScanModel> getScanById ( int id ) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //    SELECT ALL
  Future<List<ScanModel>> getScans() async {

    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
                            ? res.map((element) => ScanModel.fromJson(element)).toList()
                            : [];

    return list;

  }
  
  //    SELECT BY OTROS CAMPOS
  Future<List<ScanModel>> getScansByType( String tipo ) async {

    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo");

    List<ScanModel> list = res.isNotEmpty
                            ? res.map((element) => ScanModel.fromJson(element)).toList()
                            : [];

    return list;

  }

  // UPDATE
  Future<int> updateScan( ScanModel updateScan ) async {
    final db = await database;
    final res = await db.update('Scans', updateScan.toJson(), where: 'id = ?', whereArgs: [updateScan.id]);
    return res;
  }

  Future<int> deleteScan (int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }

}