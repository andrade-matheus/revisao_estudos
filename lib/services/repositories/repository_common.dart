import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class RepositoryCommon<T extends EntityCommon> {
  static Database _database;

  String get nomeTabela;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<T> adicionar(T param) async {
    final bd = await database;
    await bd.transaction((txn) async {
      param.id = await txn.insert(nomeTabela, param.toMap());
    });
    return param;
  }

  Future<T> obterPorId(int id) async {
    final db = await database;
    var resultado = await db.query(
      nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
    return resultado.isNotEmpty ? EntityCommon.fromMap(resultado.first) : Null;
  }

  T obterPorIdSync(int id) {
    List<Map<String, Object>> resultado = [];
    database.then((db) async {
      resultado = await db.query(
        nomeTabela,
        where: 'id = ?',
        whereArgs: [id],
      );
    });
    return resultado.isNotEmpty ? EntityCommon.fromMap(resultado.first) : Null;
  }

  Future<List<T>> obterTodos() async {
    try {
      final bd = await database;
      var resultado = await bd.query(nomeTabela);
      return resultado.isNotEmpty
          ? resultado.map((i) => EntityCommon.fromMap(i)).toList()
          : [];
    } catch (e) {
      throw e;
    }
  }

  Future<T> atualizar(T param) async {
    try {
      final db = await database;
      await db.update(
        nomeTabela,
        param.toMap(),
        where: 'id = ?',
        whereArgs: [param.id],
      );
      return param;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> existe(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        nomeTabela,
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? true : false;
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(int id) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete(
          nomeTabela,
          where: 'id = ?',
          whereArgs: [id],
        );
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> remoterTodos() async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM $nomeTabela');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<T>> adicionarVarios(List<T> param) async {
    final db = await database;
    await db.transaction((txn) async {
      param.forEach((element) async {
        await txn.insert(nomeTabela, element.toMap());
      });
    });
    return param;
  }

  Future<List<T>> atualizarVarios(List<T> param) async {
    final db = await database;
    await db.transaction((txn) async {
      param.forEach((element) async {
        await txn.update(
          nomeTabela,
          element.toMap(),
          where: 'id = ?',
          whereArgs: [element.id],
        );
      });
    });
    return param;
  }
}
