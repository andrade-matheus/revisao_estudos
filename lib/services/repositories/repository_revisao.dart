import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryRevisao extends RepositoryCommon<Revisao> {
  @override
  String get nomeTabela => 'revisao';

  @override
  Function get fromMap => Revisao.fromMap;

  // Todas revisões de um disciplina
  Future<List<Revisao>> obterPorDisciplina(Disciplina disciplina) async {
    List<Revisao> revisoes = await obterPor(
      where: 'idDisciplina = ?',
      whereArgs: [disciplina.id],
    );

    return revisoes;
  }

  Future<List<Revisao>> obterPorData(DateTime data) async {
    final bd = await database;
    var dataSql = DateHelper.formatarParaSql(data);
    var resultado = await bd.query(
      nomeTabela,
      where: 'date(proxRevisao) < ?',
      whereArgs: ["date($dataSql)"],
    );
    return await fromMapList(resultado);
  }

  Future<List<Revisao>> obterPorDataParaCalendario(DateTime data) async {
    final bd = await database;
    var dataSql = DateHelper.formatarParaSql(data);
    var resultado = await bd.query(
      nomeTabela,
      where: 'date(proxRevisao) == ?',
      whereArgs: ["date($dataSql)"],
    );
    return await fromMapList(resultado);
  }

  Future<List<Revisao>> obterEmLogPorDisciplinaPorData(Disciplina disciplina, DateTime data) async {
    final bd = await database;
    var dataSql = DateHelper.formatarParaSql(data);
    String sql = """ 
      SELECT revisao.id, idDisciplina, idFrequencia, nome, dataCadastro, proxRevisao, vezesRevisadas, isArchived
      FROM logRevisao
      INNER JOIN revisao on revisao.id = logRevisao.idRevisao
      WHERE date(proxRevisao) == date($dataSql) AND idDisciplina == ${disciplina.id}
    """;
    var resultado = await bd.rawQuery(sql);
    return await fromMapList(resultado);
  }

  // Todas revisões de uma disciplina para essa data incluindo as atrasadas.
  Future<List<Revisao>> obterPorDisciplinaPorData(Disciplina disciplina, DateTime data) async {
    List<Revisao> revisoes = await obterPor(
      where: 'idDisciplina = ? AND date(proxRevisao)',
      whereArgs: [disciplina.id],
    );

    revisoes.removeWhere((element) => element.proxRevisao.isAfter(DateHelper.amanha));
    return revisoes;
  }

  Future<List<Revisao>> obterParaCaledario(Disciplina disciplina, DateTime data) async {
    if (data.isBefore(DateHelper.hoje)) {
      return await obterEmLogPorDisciplinaPorData(disciplina, data);
    } else {
      return await obterPorDisciplinaPorData(disciplina, data);
    }
  }
}
