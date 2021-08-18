import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/services/database/database_creator.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryDisciplina {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseCreator.initBD();
    return _database;
  }

  Future<Disciplina> insert(Disciplina disciplina) async {
    try {
      final bd = await database;
      await bd.transaction((txn) async {
        await txn.insert('disciplina', disciplina.toMap());
      });
      return disciplina;
    } catch (e) {
      throw e;
    }
  }

  Future<Disciplina> getById(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'disciplina',
        where: 'id = ?',
        whereArgs: [id],
      );
      return resultado.isNotEmpty ? Disciplina.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Disciplina getByIdSync(int id) {
    List<Map<String, Object>> resultado = [];
    try {
      database.then((db) async {
        resultado = await db.query(
          'disciplina',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return resultado.isNotEmpty ? Disciplina.fromMap(resultado.first) : Null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Disciplina>> getAll() async {
    try {
      final bd = await database;
      var resultado = await bd.query('disciplina');
      return resultado.isNotEmpty
          ? resultado.map((i) => Disciplina.fromMap(i)).toList()
          : [];
    } catch (e) {
      throw e;
    }
  }

  Future<Disciplina> update(Disciplina disciplina) async {
    try {
      final db = await database;
      await db.update(
        'disciplina',
        disciplina.toMap(),
        where: 'id = ?',
        whereArgs: [disciplina.id],
      );
      return disciplina;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> exists(int id) async {
    try {
      final bd = await database;
      var resultado = await bd.query(
        'disciplina',
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
        await txn.rawDelete('DELETE FROM disciplina');
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<Disciplina>> insertRange(List<Disciplina> disciplinas) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        disciplinas.forEach((element) async {
          await txn.insert('disciplina', element.toMap());
        });
      });
      return disciplinas;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Disciplina>> updateRange(List<Disciplina> disciplinas) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        disciplinas.forEach((element) async {
          await txn.update(
            'disciplina',
            element.toMap(),
            where: 'id = ?',
            whereArgs: [element.id],
          );
        });
      });
      return disciplinas;
    } catch (e) {
      throw e;
    }
  }
}
