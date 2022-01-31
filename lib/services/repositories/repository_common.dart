import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class RepositoryCommon<T extends EntityCommon> {
  static Database? _database;

  String get nomeTabela;
  Function get fromMap;
  Future<bool> utilizado(int id);

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<T> adicionar(T param) async {
    Map<String, dynamic> map = param.toMap();
    map.remove('id');

    final bd = await database;
    await bd?.transaction((txn) async {
      param.id = await txn.insert(
        nomeTabela,
        map,
      );
    });
    return param;
  }

  Future<T?> obterPorId(int id) async {
    final db = await database;
    var resultado = await db?.query(
      nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
    return resultado?.isNotEmpty ?? false ? await fromMap(resultado?.first) as T : null;
  }

  Future<List<T>> obterTodos() async {
    final bd = await database;
    var resultado = await bd?.query(nomeTabela);
    List<T> lista =  await fromMapList(resultado ?? []);
    return lista;
  }

  Future<List<T>> obterPor({required String where, required List<Object> whereArgs}) async {
    final bd = await database;
    var resultado = await bd?.query(
      nomeTabela,
      where: where,
      whereArgs: whereArgs,
    );
    List<T> lista =  await fromMapList(resultado ?? []);
    return lista;
  }

  Future<List<T>> obterPorRawQuery(String query, List<Object> arguments) async {
    final bd = await database;
    var resultado = await bd?.rawQuery(query, arguments);
    List<T> lista =  await fromMapList(resultado ?? []);
    return lista;
  }

  Future<T> atualizar(T param) async {
    final db = await database;
    await db?.update(
      nomeTabela,
      param.toMap(),
      where: 'id = ?',
      whereArgs: [param.id],
    );
    return param;
  }

  Future<bool> existe(int id) async {
    final bd = await database;
    var resultado = await bd?.query(
      nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
    return resultado?.isNotEmpty ?? false;
  }

  Future<bool> remover(int id, {bool force = false}) async {
    if(!force && await utilizado(id))
      return false;

    final db = await database;
    await db?.transaction((txn) async {
      await txn.delete(
        nomeTabela,
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    return true;
  }

  Future<void> remoterTodos() async {
    final db = await database;
    await db?.transaction((txn) async {
      await txn.rawDelete('DELETE FROM $nomeTabela');
    });
  }

  Future<List<T>> adicionarVarios(List<T> param) async {
    final db = await database;
    await db?.transaction((txn) async {
      param.forEach((element) async {
        await txn.insert(nomeTabela, element.toMap());
      });
    });
    param.sort((a,b) => a.compareTo(b));
    return param;
  }

  Future<List<T>> atualizarVarios(List<T> param) async {
    final db = await database;
    await db?.transaction((txn) async {
      param.forEach((element) async {
        await txn.update(
          nomeTabela,
          element.toMap(),
          where: 'id = ?',
          whereArgs: [element.id],
        );
      });
    });
    param.sort((a,b) => a.compareTo(b));
    return param;
  }

  Future<List<T>> fromMapList(List<Map> param) async {
    List<T> lista = [];
    if (param.isNotEmpty) {
      for (var item in param) {
        lista.add(await fromMap(item) as T);
      }
    } else {
      lista = new List<T>.from([]);
    }
    lista.sort((a,b) => a.compareTo(b));
    return lista;
  }
}
