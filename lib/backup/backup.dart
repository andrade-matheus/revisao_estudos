import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

class Backup {
  
  List<String> tables = [
    DatabaseController.revisaoTable,
    DatabaseController.logRevisaoTable,
    DatabaseController.disciplinaTable,
    DatabaseController.frequenciaTable,
  ];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/backup.json');
  }

  Future<File> writeToBackupFile(String json) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(json);
  }

  Future<String> readFile(String path) async {
    try {
      final file = File(path);

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (error) {
      // If encountering an error, return error.
      return error.toString();
    }
  }

  Future<String> _databasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, "database.db");
  }

  Future deleteDB() async {
    String path = await _databasePath();
    await deleteDatabase(path);
  }

  Future clearAllTables() async {
    try {
      for (String table in tables) {
        await db.delete(table);
        print('------ DELETE $table');
      }
    } catch (e) {}
  }

  Future<String> generateBackup() async {
    print('GENERATE BACKUP');

    List data = [];

    List<Map<String, dynamic>> listMaps = [];

    for (var i = 0; i < tables.length; i++) {
      listMaps = await db.query(tables[i]);

      data.add(listMaps);
    }

    List backups = [tables, data];

    String json = convert.jsonEncode(backups);

    writeToBackupFile(json);

    return json;
  }

  Future<void> restoreBackup(String path) async {

    String backup = await readFile(path);
    print(backup);
    // Batch batch = db.batch();
    //
    // List json = convert.jsonDecode(backup);
    //
    // for (var i = 0; i < json[0].length; i++) {
    //   for (var k = 0; k < json[1][i].length; k++) {
    //     batch.insert(json[0][i], json[1][i][k]);
    //   }
    // }
    //
    // await batch.commit(continueOnError: false, noResult: true);
    print('RESTORE BACKUP');
  }
}
