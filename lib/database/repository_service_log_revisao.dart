import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/log_revisao_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class RepositoryServiceLogRevisao {
  static Future<List<LogRevisao>> getAllLogRevisoes() async {
    List<Map> maps = await db.query(
      DatabaseController.logRevisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.idRevisao,
        DatabaseController.dataRevisao
      ],
    );

    List<LogRevisao> logRevisoes = List();
    Map item;

    for (item in maps) {
      logRevisoes.add(await LogRevisaoController.logRevisaoFromMap(item));
    }
    return logRevisoes;
  }

  static Future<List<Revisao>> getLogRevisoesByDate(DateTime data) async {
    List<Map> maps = await db.query(
      DatabaseController.logRevisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.idRevisao,
        DatabaseController.dataRevisao
      ],
      where: '${DatabaseController.dataRevisao} = ?',
      whereArgs: [DatabaseController.formatarData(data)],
    );

    List<LogRevisao> logRevisoes = List();
    List<Revisao> revisoes = List();
    Map item;

    for (item in maps) {
      logRevisoes.add(await LogRevisaoController.logRevisaoFromMap(item));
    }

    LogRevisao log;
    for(log in logRevisoes){
      revisoes.add(log.revisao);
    }

    return revisoes;
  }

  static Future<LogRevisao> getLogRevisao(int id) async {
    List<Map> maps = await db.query(DatabaseController.logRevisaoTable,
        columns: [
          DatabaseController.id,
          DatabaseController.idRevisao,
          DatabaseController.dataRevisao,
        ],
        where: '${DatabaseController.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return await LogRevisaoController.logRevisaoFromMap(maps.first);
    }
    return null;
  }

  static Future<int> insertLogRevisao(LogRevisao logRevisao) async {
    return await db.insert(
        DatabaseController.logRevisaoTable, LogRevisaoController.logRevisaoToMap(logRevisao));
  }

  static Future<int> deleteLogRevisao(LogRevisao logRevisao) async {
    return await db.delete(DatabaseController.logRevisaoTable,
        where: '${DatabaseController.id} = ?', whereArgs: [logRevisao.id]);
  }

  static Future<int> updateLogRevisao(LogRevisao logRevisao) async {
    return await db.update(
        DatabaseController.logRevisaoTable, LogRevisaoController.logRevisaoToMap(logRevisao),
        where: '${DatabaseController.id} = ?', whereArgs: [logRevisao.id]);
  }
}
