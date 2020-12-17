import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class RepositoryServiceRevisao {

  static Future<List<Revisao>> getAllRevisoes() async {
    List<Map> maps = await db.query(
      DatabaseController.revisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.nome,
        DatabaseController.idDisciplina,
        DatabaseController.idFrequencia,
        DatabaseController.dataCadastro,
        DatabaseController.proxRevisao,
        DatabaseController.vezesRevisadas,
        DatabaseController.isArchived,
      ],
      where: '${DatabaseController.isArchived} = 0',
    );

    List<Revisao> revisoes = List();
    Map item;

    for (item in maps) {
      revisoes.add(await RevisaoController.revisaoFromMap(item));
    }
    return revisoes;
  }

  static Future<List<Revisao>> getRevisoesByDisciplina(
      Disciplina disciplina) async {
    List<Map> maps = await db.query(
      DatabaseController.revisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.nome,
        DatabaseController.idDisciplina,
        DatabaseController.idFrequencia,
        DatabaseController.dataCadastro,
        DatabaseController.proxRevisao,
        DatabaseController.vezesRevisadas,
        DatabaseController.isArchived,
      ],
      where:
          '${DatabaseController.isArchived} = 0 AND ${DatabaseController.idDisciplina} = ?',
      whereArgs: [disciplina.id],
    );

    List<Revisao> revisoes = List();
    Map item;

    for (item in maps) {
      revisoes.add(await RevisaoController.revisaoFromMap(item));
    }

    return revisoes;
  }

  static Future<List<Revisao>> getRevisoesByDate(DateTime data) async {
    List<Map> maps = await db.query(
      DatabaseController.revisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.nome,
        DatabaseController.idDisciplina,
        DatabaseController.idFrequencia,
        DatabaseController.dataCadastro,
        DatabaseController.proxRevisao,
        DatabaseController.vezesRevisadas,
        DatabaseController.isArchived,
      ],
      where:
          '${DatabaseController.isArchived} = 0 AND ${DatabaseController.proxRevisao} = ?',
      whereArgs: [DatabaseController.formatarData(data)],
    );

    List<Revisao> revisoes = List();
    Map item;

    for (item in maps) {
      revisoes.add(await RevisaoController.revisaoFromMap(item));
    }

    return revisoes;
  }

  static Future<List<Revisao>> getRevisoesByDisciplinaAndDate(
      Disciplina disciplina, DateTime data) async {
    List<Map> maps = await db.query(
      DatabaseController.revisaoTable,
      columns: [
        DatabaseController.id,
        DatabaseController.nome,
        DatabaseController.idDisciplina,
        DatabaseController.idFrequencia,
        DatabaseController.dataCadastro,
        DatabaseController.proxRevisao,
        DatabaseController.vezesRevisadas,
        DatabaseController.isArchived,
      ],
      where:
          '${DatabaseController.isArchived} = 0 AND ${DatabaseController.idDisciplina} = ? AND ${DatabaseController.proxRevisao} = ?',
      whereArgs: [disciplina.id, DatabaseController.formatarData(data)],
    );

    List<Revisao> revisoes = List();
    Map item;

    for (item in maps) {
      revisoes.add(await RevisaoController.revisaoFromMap(item));
    }
    return revisoes;
  }

  static Future<Revisao> getRevisao(int id) async {
    List<Map> maps = await db.query(DatabaseController.revisaoTable,
        columns: [
          DatabaseController.id,
          DatabaseController.nome,
          DatabaseController.idDisciplina,
          DatabaseController.idFrequencia,
          DatabaseController.dataCadastro,
          DatabaseController.proxRevisao,
          DatabaseController.vezesRevisadas,
          DatabaseController.isArchived,
        ],
        where: '${DatabaseController.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return await RevisaoController.revisaoFromMap(maps.first);
    }
    return null;
  }

  static Future<int> insertRevisao(Revisao revisao) async {
    return await db.insert(DatabaseController.revisaoTable,
        RevisaoController.revisaoToMap(revisao));
  }

  static Future<int> deleteRevisao(Revisao revisao) async {
    return await db.delete(DatabaseController.revisaoTable,
        where: '${DatabaseController.id} = ?', whereArgs: [revisao.id]);
  }

  static Future<int> updateRevisao(Revisao revisao) async {
    return await db.update(DatabaseController.revisaoTable,
        RevisaoController.revisaoToMap(revisao),
        where: '${DatabaseController.id} = ?', whereArgs: [revisao.id]);
  }
}
