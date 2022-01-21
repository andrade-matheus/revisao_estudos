import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryRevisao extends RepositoryCommon<Revisao> {
  @override
  String get nomeTabela => 'revisao';

  @override
  Function get fromMap => Revisao.fromMap;

  @override
  Future<bool> utilizado(int id) async {
    return false;
  }

  // Todas revisões de uma disciplina
  Future<List<Revisao>> obterPorDisciplina(int disciplinaId) async {
    List<Revisao> revisoes = await obterPor(
      where: 'idDisciplina = ?',
      whereArgs: [disciplinaId],
    );
    return revisoes;
  }

  // Todas revisões de uma frequência
  Future<List<Revisao>> obterPorFrequencia(int frequenciaId) async {
    List<Revisao> revisoes = await obterPor(
      where: 'idFrequencia = ?',
      whereArgs: [frequenciaId],
    );
    return revisoes;
  }

  // Retorna revisões para data selecionada, incluindo as atrasadas.
  Future<List<Revisao>> obterPorData(DateTime data) async {
    final bd = await database;
    var dataSql = DateHelper.formatarParaSql(data);
    var resultado = await bd?.query(
      nomeTabela,
      where: 'date(proxRevisao) < ?',
      whereArgs: ["date($dataSql)"],
    );
    return await fromMapList(resultado ?? []);
  }

  Future<List<Revisao>> obterParaCaledario(Disciplina disciplina, DateTime data) async {
    if (data.isBefore(DateHelper.hoje())) {
      return await obterEmLogPorDisciplinaPorData(disciplina, data);
    } else if (data.isBefore(DateHelper.amanha())) {
      return await obterPorDisciplinaPorDataComAtrasadas(disciplina, data);
    } else {
      return await obterPorDisciplinaPorData(disciplina, data);
    }
  }

  // Retorna as revisões que foram concluídas de uma disciplina em determinada data.
  Future<List<Revisao>> obterEmLogPorDisciplinaPorData(Disciplina disciplina, DateTime data) async {
    String query = """SELECT revisao.id, 
                              idDisciplina, 
                              idFrequencia, 
                              nome, 
                              dataCadastro, 
                              proxRevisao, 
                              vezesRevisadas, 
                              isArchived
                      FROM logRevisao
                      INNER JOIN revisao on revisao.id = logRevisao.idRevisao
                      WHERE date(dataRevisao) = date(?) AND idDisciplina = ?;""";

    List<Object> arguments = [DateHelper.formatarParaSql(data), disciplina.id];
    return await obterPorRawQuery(query, arguments);
  }

  // Retorna as revisões de uma disciplina em determinada data.
  Future<List<Revisao>> obterPorDisciplinaPorData(Disciplina disciplina, DateTime data) async {
    String query = """SELECT *
                      FROM revisao
                      WHERE date(proxRevisao) = date(?) AND idDisciplina == ?;""";

    List<Object> arguments = [DateHelper.formatarParaSql(data), disciplina.id];
    return await obterPorRawQuery(query, arguments);
  }

  // Retorna as revisões de uma disciplina para determinada data, mais as revisões atrasadas (de datas anteriores).
  Future<List<Revisao>> obterPorDisciplinaPorDataComAtrasadas(Disciplina disciplina, DateTime data) async {
    String query = """SELECT *
                      FROM revisao
                      WHERE date(proxRevisao) <= date(?) AND idDisciplina == ?;""";

    List<Object> arguments = [DateHelper.formatarParaSql(data), disciplina.id];
    return await obterPorRawQuery(query, arguments);
  }

  // Retorna as revisões que tem Logs de Revisão para esse determinada data.
  Future<List<Revisao>> obterTodasComLogRevisoesPorData(DateTime data) async {
    String query = """SELECT revisao.id, idDisciplina, idFrequencia, nome, dataCadastro, proxRevisao, vezesRevisadas, isArchived
                      FROM logRevisao 
                      INNER JOIN revisao ON logRevisao.idRevisao = revisao.id
                      INNER JOIN disciplina ON revisao.idDisciplina = disciplina.id
                      WHERE date(logRevisao.dataRevisao) = date(?);
                      """;
    List<Object> arguments = [DateHelper.formatarParaSql(data)];
    return await obterPorRawQuery(query, arguments);
  }
}
