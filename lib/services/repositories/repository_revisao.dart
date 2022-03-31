import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryRevisao extends RepositoryCommon<Revisao> {
  @override
  String get tableName => 'revisao';

  @override
  Function get fromMap => Revisao.fromMap;

  @override
  Future<bool> isBeingUsed(int id) async {
    return false;
  }

  // Todas revisões de uma disciplina
  Future<List<Revisao>> obterPorDisciplina(int disciplinaId) async {
    List<Revisao> revisoes = await getByQuery(
      where: 'idDisciplina = ?',
      whereArgs: [disciplinaId],
    );
    return revisoes;
  }

  // Todas revisões de uma frequência
  Future<List<Revisao>> obterPorFrequencia(int frequenciaId) async {
    List<Revisao> revisoes = await getByQuery(
      where: 'idFrequencia = ?',
      whereArgs: [frequenciaId],
    );
    return revisoes;
  }

  Future<List<Revisao>> obterParaDisciplinaTile(int disciplinaId, DateTime? data) async {
    if (data != null) {
      int isToday = DateHelper.isToday(data);
      if (isToday < 0) {
        return obterParaDisciplina(disciplinaId, data, false, true);
      } else if (isToday == 0) {
        return obterParaDisciplina(disciplinaId, data, true, false);
      } else if (isToday > 0) {
        return obterParaDisciplina(disciplinaId, data, false, false);
      }
    }
    return obterParaDisciplina(disciplinaId, null, false, false);
  }

  // Método que retorna uma lista de revisões para composição dos objetos de disciplina
  Future<List<Revisao>> obterParaDisciplina(int disciplinaId, DateTime? data, bool? atrasadas, bool? isLog) async {
    String query =
        'SELECT revisao.id, idDisciplina, idFrequencia, nome, dataCadastro, proxRevisao, vezesRevisadas, isArchived FROM revisao';
    List<Object> arguments = [];

    if (data != null) {
      if (isLog ?? false) {
        query += ' INNER JOIN logRevisao ON logRevisao.idRevisao = revisao.id';
        query +=
            ' WHERE date(logRevisao.dataRevisao) = date(?) AND idDisciplina == ?';
      } else if (atrasadas ?? false) {
        query += ' WHERE date(proxRevisao) < ? AND idDisciplina = ?';
      } else {
        query += ' WHERE date(proxRevisao) = ? AND idDisciplina = ?';
      }
      arguments.add(DateHelper.formatarParaSql(data));
      arguments.add(disciplinaId);
    } else {
      query += ' WHERE idDisciplina == ?';
      arguments.add(disciplinaId);
    }

    return await obterPorRawQuery(query, arguments);
  }
}
