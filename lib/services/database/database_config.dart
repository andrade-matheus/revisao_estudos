import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revisao_estudos/services/database/comandos_sql.dart';
import 'package:sqflite/sqflite.dart';

import 'databe_migrator.dart';

class DatabaseConfig {
  static List<String> tables = [
    'disciplina',
    'frequencia',
    'revisao',
    'logRevisao',
  ];

  static initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dados.db');
    var maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
    print(maxMigratedDbVersion);

    return await openDatabase(
      path,
      version: maxMigratedDbVersion,
      onOpen: (db) {
        print('Abrindo o DB...');
      },
      onCreate: (Database db, int version) async {
        print('Criando o DB...');
        DbMigrator.migrations.keys.toList()
          ..sort()
          ..forEach((element) async {
            var script = DbMigrator.migrations[element];
            await db.execute(script);
          });
      },
      onUpgrade: (db, _, __) async {
        print('Atualizando o DB...');
        var currentDbVersion = await getCurrentDbVersion(db);
        print('Atual versão do DB: $currentDbVersion');

        var upgradeScripts = Map.fromIterable(
            DbMigrator.migrations.keys
                .where((element) => element > currentDbVersion),
            key: (element) => element,
            value: (element) => DbMigrator.migrations[element]);

        if (upgradeScripts.length == 0) return;

        upgradeScripts.keys.toList()
          ..sort()
          ..forEach((element) async {
            var script = upgradeScripts[element];
            await db.execute(script);
          });

        _upgradeDbVersion(db, maxMigratedDbVersion);
      },
      onConfigure: (db) async {
        await db.execute(ComandosSQL.foreignKeys);
      },
    );
  }

  static void _upgradeDbVersion(Database db, int version) async {
    await db.rawQuery("pragma user_version = $version;");
  }

  static Future<int> getCurrentDbVersion(Database db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]["user_version"].toString();
    return int.parse(version);
  }

  Future<String> _databasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, "database.db");
  }

  Future deleteDB() async {
    String path = await _databasePath();
    await deleteDatabase(path);
  }

  static void clearAllTables() async {
    try {
      var db = await initDB();
      for (String table in tables) {
        await db.delete(table);
        print('------ DELETE $table');
      }
    } catch (e) {}
  }
}
