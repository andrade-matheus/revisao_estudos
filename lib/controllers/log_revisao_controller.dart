import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/database/repository_service_log_revisao.dart';
import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class LogRevisaoController {
  // CONSTRUTOR FROM MAP:
  static logRevisaoFromMap(Map<String, dynamic> map) async {
    LogRevisao logRevisao = LogRevisao(
      map[DatabaseController.id],
      await RevisaoController.obterRevisao(map[DatabaseController.idRevisao]),
      DateTime.parse(map[DatabaseController.dataRevisao]),
    );
    return logRevisao;
  }

  static Map<String, dynamic> logRevisaoToMap(LogRevisao logRevisao) {
    var map = <String, dynamic>{
      DatabaseController.idRevisao: logRevisao.revisao.id,
      DatabaseController.dataRevisao: DatabaseController.formatarData(logRevisao.dataRevisao),
    };
    return map;
  }

  // CONVERÕES DE / PARA JSON
  static Future<LogRevisao> fromJson(Map<String, dynamic> json) async {
    LogRevisao logRevisao = LogRevisao(
        json['id'],
        await RevisaoController.obterRevisao(json['revisao']),
        DateTime(json['dataLogRevisao']));
    return logRevisao;
  }

  Map<String, dynamic> toJson(LogRevisao logRevisao) {
    Map<String, dynamic> json = {
      'id': logRevisao.id,
      'revisao': logRevisao.revisao.id,
      'dataLogRevisao': DatabaseController.formatarData(logRevisao.dataRevisao)
    };
    return json;
  }

  // OBTER LOGS DAS REVISÕES
  static obterTodosLogRevisoes() async {
    List<LogRevisao> logRevisoes =
        await RepositoryServiceLogRevisao.getAllLogRevisoes();
    return logRevisoes;
  }

  static obterTodosLogRevisoesPorData(DateTime data) async {
    List<Revisao> logRevisoes =
        await RepositoryServiceLogRevisao.getLogRevisoesByDate(data);
    return logRevisoes;
  }

  static obterRevisoesDosLogsPorData(DateTime data) async {
    List<Revisao> revisoesLog =
        await RepositoryServiceLogRevisao.getLogRevisoesByDate(data);
    return revisoesLog;
  }

  static obterLogRevisao(int id) async {
    LogRevisao logRevisao = await RepositoryServiceLogRevisao.getLogRevisao(id);
    return logRevisao;
  }

  // CRUD DOS LOGS DAS REVISÕES
  static criarLogRevisao(LogRevisao logRevisao) async {
    await RepositoryServiceLogRevisao.insertLogRevisao(logRevisao);
  }

  static atualizarLogRevisao(LogRevisao logRevisao) async {
    await RepositoryServiceLogRevisao.updateLogRevisao(logRevisao);
  }

  static deletarLogRevisao(LogRevisao logRevisao) async {
    await RepositoryServiceLogRevisao.deleteLogRevisao(logRevisao);
  }
}
