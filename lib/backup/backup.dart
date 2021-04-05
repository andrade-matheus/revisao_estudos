import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

class Backup {

  List<String> tables = [
    DatabaseController.disciplinaTable,
    DatabaseController.frequenciaTable,
    DatabaseController.revisaoTable,
    DatabaseController.logRevisaoTable,
  ];

  // CRIAÇÃO DO BACKUP

  Future<bool> gerarBackup() async {
    print('GERANDO BACKUP');

    List data = [];

    List<Map<String, dynamic>> listMaps = [];

    for (var i = 0; i < tables.length; i++) {
      listMaps = await db.query(tables[i]);
      data.add(listMaps);
    }

    List backups = [tables, data];
    String json = convert.jsonEncode(backups);
    writeToBackupFile(json);

    return true;
  }

  Future<File> writeToBackupFile(String json) async {
    String path = await FilePicker.platform.getDirectoryPath();
    final file = File('$path/revisao_backup.txt');
    // Write the file.
    return file.writeAsString(json);
  }

  // RESTAURANDO O BACKUP
  Future<void> restoreBackup() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null) {
      String path = result.files.single.path;
      String backup = await readFile(path);

      await clearAllTables();

      Batch batch = db.batch();
      List json = convert.jsonDecode(backup);

      for (var i = 0; i < json[0].length; i++) {
        for (var k = 0; k < json[1][i].length; k++) {
          batch.insert(json[0][i], json[1][i][k]);
        }
      }

      await batch.commit(continueOnError: false, noResult: true);
      print('BACKUP RESTAURADO COM SUCESSO!!');
    }
    else{
      print('NÃO FOI POSSIVEL RESTAURAR O BACKUP');
    }
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
}
