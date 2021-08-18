import 'package:revisao_estudos/models/classes/frequencia.dart';
import 'package:revisao_estudos/services/database/database_creator.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryFrequencia {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseCreator.initBD();
    return _database;
  }

  Future<Frequencia> insert(Frequencia frequencia) async {
    try {
      final bd = await database;
      await bd.transaction((txn) async {
        await txn.insert('frequencia', frequencia.toMap());
      });
      return frequencia;
    } catch (e) {
      throw e;
    }
  }

  Future<Frequencia> getById(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'frequencia',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? Frequencia.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Frequencia getByIdSync(int id) {
    List<Map<String, Object>> resultado = [];
    try {
      database.then((db) async {
        resultado = await db.query(
          'frequencia',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return resultado.isNotEmpty ? Frequencia.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Frequencia>> getAll() async {
    try {
      final bd = await database;
      var resultado = await bd.query('frequencia');
      return resultado.isNotEmpty
          ? resultado.map((i) => Frequencia.fromMap(i)).toList()
          : [];
    } catch (e) {
      throw e;
    }
  }

  Future<Frequencia> update(Frequencia frequencia) async {
    try {
      final db = await database;
      await db.update(
        'frequencia',
        frequencia.toMap(),
        where: 'id = ?',
        whereArgs: [frequencia.id],
      );
      return frequencia;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> exists(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'frequencia',
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
        await txn.rawDelete('DELETE FROM frequencia');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<Frequencia>> insertRange(List<Frequencia> frequencias) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        frequencias.forEach((element) async {
          await txn.insert('frequencia', element.toMap());
        });
      });
      return frequencias;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Frequencia>> updateRange(List<Frequencia> frequencias) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        frequencias.forEach((element) async {
          await txn.update(
            'frequencia',
            element.toMap(),
            where: 'id = ?',
            whereArgs: [element.id],
          );
        });
      });
      return frequencias;
    } catch (e) {
      throw e;
    }
  }
}
