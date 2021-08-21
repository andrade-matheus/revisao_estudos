import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryRevisao extends RepositoryCommon {
  @override
  String get nomeTabela => 'revisao';

  // Todas revisões para essa data incluindo as atrasadas.
  Future<List<Revisao>> getAllPorData(DateTime data) async {
    final bd = await database;
    var resultado = await bd.query('Revisao');
    List<Revisao> revisoes = resultado.isNotEmpty
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
}
