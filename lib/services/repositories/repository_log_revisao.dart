import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryLogRevisao {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<LogRevisao> insert(LogRevisao logRevisao) async {
    try {
      final bd = await database;
      await bd.transaction((txn) async {
        await txn.insert('logRevisao', logRevisao.toMap());
      });
      return logRevisao;
    } catch (e) {
      throw e;
    }
  }

  Future<LogRevisao> getById(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'logRevisao',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? LogRevisao.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  LogRevisao getByIdSync(int id) {
    List<Map<String, Object>> resultado = [];
    try {
      database.then((db) async {
        resultado = await db.query(
          'logRevisao',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return resultado.isNotEmpty ? LogRevisao.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LogRevisao>> getAll() async {
    try {
      final bd = await database;
      var resultado = await bd.query('logRevisao');
      return resultado.isNotEmpty
          ? resultado.map((i) => LogRevisao.fromMap(i)).toList()
          : [];
    } catch (e) {
      throw e;
    }
  }

  Future<LogRevisao> update(LogRevisao logRevisao) async {
    try {
      final db = await database;
      await db.update(
        'logRevisao',
        logRevisao.toMap(),
        where: 'id = ?',
        whereArgs: [logRevisao.id],
      );
      return logRevisao;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> exists(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'logRevisao',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? true : false;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM logRevisao');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<LogRevisao>> insertRange(List<LogRevisao> logRevisoes) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        logRevisoes.forEach((element) async {
          await txn.insert('logRevisao', element.toMap());
        });
      });
      return logRevisoes;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LogRevisao>> updateRange(List<LogRevisao> logRevisoes) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        logRevisoes.forEach((element) async {
          await txn.update(
            'logRevisao',
            element.toMap(),
            where: 'id = ?',
            whereArgs: [element.id],
          );
        });
      });
      return logRevisoes;
    } catch (e) {
      throw e;
    }
  }
}
