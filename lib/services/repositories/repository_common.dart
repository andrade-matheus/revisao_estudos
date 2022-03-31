import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class RepositoryCommon<T extends EntityCommon> {
  static Database? _database;

  String get _tableName;
  Function get fromMap;
  Future<bool> isBeingUsed(int id);

  Future<Database?> get database async {
    if (_database != null)
      return _database;

    _database = await DatabaseConfig.initDB();

    return _database;
  }

  Future<T> add(T item) async {
    Map<String, dynamic> map = item.toMap();
    map.remove('id');

    final bd = await database;
    await bd?.transaction((txn) async {
      item.id = await txn.insert(
        _tableName,
        map,
      );
    });
    return item;
  }

  Future<T?> getById(int id) async {
    final db = await database;
    var result = await db?.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.isNotEmpty ?? false ? await fromMap(result?.first) as T : null;
  }

  Future<List<T>> getAll() async {
    final bd = await database;
    var result = await bd?.query(_tableName);
    List<T> lista =  await fromMapListToItemList(result ?? []);
    return lista;
  }

  Future<List<T>> getByQuery({required String where, required List<Object> whereArgs}) async {
    final bd = await database;
    var result = await bd?.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );
    List<T> lista =  await fromMapListToItemList(result ?? []);
    return lista;
  }

  Future<List<T>> obterPorRawQuery(String query, List<Object> arguments) async {
    final bd = await database;
    var result = await bd?.rawQuery(query, arguments);
    List<T> lista =  await fromMapListToItemList(result ?? []);
    return lista;
  }

  Future<T> update(T param) async {
    final db = await database;
    await db?.update(
      _tableName,
      param.toMap(),
      where: 'id = ?',
      whereArgs: [param.id],
    );
    return param;
  }

  Future<bool> delete(int id, {bool forceDelete = false}) async {
    if(!forceDelete && await isBeingUsed(id))
      return false;

    final db = await database;
    await db?.transaction((txn) async {
      await txn.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    return true;
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db?.transaction((txn) async {
      await txn.rawDelete('DELETE FROM $_tableName');
    });
  }

  Future<List<T>> fromMapListToItemList(List<Map> mapList) async {
    List<T> items = [];
    if (mapList.isNotEmpty) {
      for (var map in mapList) {
        items.add(await fromMap(map) as T);
      }
    } else {
      items = new List<T>.from([]);
    }
    items.sort((a,b) => a.compareTo(b));
    return items;
  }
}
