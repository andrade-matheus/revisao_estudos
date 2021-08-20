import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryRevisao {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<Revisao> insert(Revisao revisao) async {
    try {
      final bd = await database;
      await bd.transaction((txn) async {
        await txn.insert('Revisao', revisao.toMap());
      });
      return revisao;
    } catch (e) {
      throw e;
    }
  }

  Future<Revisao> getById(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'Revisao',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? Revisao.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Revisao getByIdSync(int id) {
    List<Map<String, Object>> resultado = [];
    try {
      database.then((db) async {
        resultado = await db.query(
          'Revisao',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return resultado.isNotEmpty ? Revisao.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Revisao>> getAll() async {
    try {
      final bd = await database;
      var resultado = await bd.query('Revisao');
      return resultado.isNotEmpty
          ? resultado.map((i) => Revisao.fromMap(i)).toList()
          : [];
    } catch (e) {
      throw e;
    }
  }

  // Todas revisões para essa data incluindo as atrasadas.
  Future<List<Revisao>> getAllPorData(DateTime data) async {
    final bd = await database;
    var resultado = await bd.query('Revisao');
    var revisoes = resultado.isNotEmpty
        ? resultado.map((i) => Revisao.fromMap(i)).toList()
        : [];

    for (var revisao in revisoes) {
      if (revisao.proxRevisao.isAfter(DateHelper.amanha)) {
        revisoes.removeWhere((element) => element.id == revisao.id);
      }
    }
    return revisoes;
  }

  Future<List<Revisao>> getAllByDisciplina(Disciplina disciplina) async {
    final bd = await database;
    var resultado = await bd.query(
      'Revisao',
      where: 'idDisciplina = ?',
      whereArgs: [disciplina.id],
    );
    return resultado.isNotEmpty
        ? resultado.map((i) => Revisao.fromMap(i)).toList()
        : [];
  }

  // Todas revisões de uma disciplina para essa data incluindo as atrasadas.
  Future<List<Revisao>> getAllByDisciplinaPorData(
    Disciplina disciplina,
    DateTime data,
  ) async {
    final bd = await database;
    var resultado = await bd.query(
      'Revisao',
      where: 'idDisciplina = ?',
      whereArgs: [disciplina.id],
    );
    var revisoes = resultado.isNotEmpty
        ? resultado.map((i) => Revisao.fromMap(i)).toList()
        : [];

    for (var revisao in revisoes) {
      if (revisao.proxRevisao.isAfter(DateHelper.amanha)) {
        revisoes.removeWhere((element) => element.id == revisao.id);
      }
    }
    return revisoes;
  }

  Future<Revisao> update(Revisao revisao) async {
    try {
      final db = await database;
      await db.update(
        'Revisao',
        revisao.toMap(),
        where: 'id = ?',
        whereArgs: [revisao.id],
      );
      return revisao;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> exists(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'Revisao',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? true : false;
    } catch (e) {
      throw e;
    }
  }

  Future<void> delete(int id) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete(
          'revisao',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM Revisao');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<Revisao>> insertRange(List<Revisao> logRevisoes) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        logRevisoes.forEach((element) async {
          await txn.insert('Revisao', element.toMap());
        });
      });
      return logRevisoes;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Revisao>> updateRange(List<Revisao> logRevisoes) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        logRevisoes.forEach((element) async {
          await txn.update(
            'Revisao',
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
