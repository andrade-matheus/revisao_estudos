import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'databe_migrator.dart';

class DatabaseCreator {
  static initBD() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dados.db');
    var maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
    print(maxMigratedDbVersion);

    return await openDatabase(
      path,
      version: maxMigratedDbVersion,
      onOpen: (db) {
        print('Abrindo o BD...');
      },
      onCreate: (Database db, int version) async {
        print('Criando o BD...');
        DbMigrator.migrations.keys.toList()
          ..sort()
          ..forEach((element) async {
            var script = DbMigrator.migrations[element];
            await db.execute(script);
          });
      },
      onUpgrade: (db, _, __) async {
        print('Atualizando o BD...');
        var currentDbVersion = await getCurrentDbVersion(db);
        print('Atual versão do BD: $currentDbVersion');

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
}
