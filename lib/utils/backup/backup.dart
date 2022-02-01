import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

class Backup {
  static Database? _database;
  List<String> tables = [
    'disciplina',
    'frequencia',
    'revisao',
    'logRevisao',
  ];

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  // CRIAÇÃO DO BACKUP
  Future<String?> gerarBackup() async {
    try {
      print('GERANDO BACKUP');

      Map<String, dynamic> backup = {};
      final db = await database;

      // Adicionando o nome das tableas ao Backup
      backup['tables'] = tables;

      // Adicionando os dados das tabelas no Backup
      for (var table in tables) {
        var result = await db?.query(table);
        backup[table] = result;
      }

      Directory? diretorio = await getExternalStorageDirectory();
      print(diretorio?.path);

      String json = convert.jsonEncode(backup);
      if (diretorio != null) {
        String path = diretorio.path;
        final file = File('$path/revisao_backup_${DateHelper.formatarParaArquivo(DateTime.now())}.txt');
        file.writeAsString(json);
        return path;
      }

      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // RESTAURANDO O BACKUP
  Future<int> restoreBackup() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String path = result.files.single.path ?? '';
        String backup = await readFile(path);

        final db = await database;
        Batch? batch = db?.batch();
        // Map<String, dynamic> json = convert.jsonDecode(backup);
        var json = convert.jsonDecode(backup);

        // Apagando os dados do Banco de Dados.
        for (String table in tables) {
          batch?.delete(table);
          print('------ DELETE $table');
        }

        for (String table in tables) {
          var dados = json[table];
          for (var dado in dados){
            batch?.insert(table, dado);
          }
        }

        await batch?.commit(continueOnError: false, noResult: true);

        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return -1;
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
}
