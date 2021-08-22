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
  Future<List<Revisao>> obterTodosPorDisciplina(Disciplina disciplina) async {
    List<Revisao> revisoes = await obterTodosPor(
      where: 'idDisciplina = ?',
      whereArgs: [disciplina.id],
    );

    return revisoes;
  }

  // Todas revisões para essa data incluindo as atrasadas.
  Future<List<Revisao>> obterTodosPorData(DateTime data) async {
    List<Revisao> revisoes = await obterTodos();
    revisoes.removeWhere(
        (element) => element.proxRevisao.isAfter(DateHelper.amanha));
    return revisoes;
  }

  // Todas revisões de uma disciplina para essa data incluindo as atrasadas.
  Future<List<Revisao>> obterTodosPorDisciplinaPorData(
    Disciplina disciplina,
    DateTime data,
  ) async {
    List<Revisao> revisoes = await obterTodosPor(
      where: 'idDisciplina = ?',
      whereArgs: [disciplina.id],
    );

    for (var revisao in revisoes) {
      if (revisao.proxRevisao.isAfter(DateHelper.amanha)) {
        revisoes.removeWhere((element) => element.id == revisao.id);
      }
    }
    return revisoes;
  }
}
