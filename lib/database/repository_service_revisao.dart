
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/disciplina.dart';

import 'database_creator.dart';
import 'package:revisao_estudos/models/revisao.dart';


class RepositoryServiceRevisao {
  static Future<List<Revisao>> getAllRevisoes() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.isArchived} = 0''';
    final data = await db.rawQuery(sql);
    List<Revisao> revisoes = List();

    for (final node in data) {
      final revisao = Revisao.fromJson(node);
      revisoes.add(revisao);
    }
    return revisoes;
  }

  static Future<Revisao> getRevisao(int id) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final revisao = Revisao.fromJson(data.first);
    return revisao;
  }

  static Future<List<Revisao>> getRevisaoByDisciplina(String disciplina) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.disciplina} = ? AND ${DatabaseCreator.isArchived} = 0''';

    List<dynamic> params = [disciplina];
    final data = await db.rawQuery(sql, params);

    List<Revisao> revisoes = List();

    for (final node in data) {
      final revisao = Revisao.fromJson(node);
      revisoes.add(revisao);
    }
    // print(revisoes.length);
    return revisoes;
  }

  static Future<List<Revisao>> getRevisoesByDate(DateTime dataRevisao) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.proxRevisao} = ? AND ${DatabaseCreator.isArchived} = 0''';

    List<dynamic> params = [
      formatarData(dataRevisao)
    ];
    final data = await db.rawQuery(sql, params);

    List<Revisao> revisoes = List();

    for (final node in data) {
      final revisao = Revisao.fromJson(node);
      revisoes.add(revisao);
    }
    // print(revisoes.length);
    return revisoes;
  }

  static Future<List<Revisao>> getRevisoesByDisciplinaAndDate(Disciplina disciplina, DateTime dataRevisao) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.disciplina} = ? 
    AND ${DatabaseCreator.proxRevisao} = ? 
    AND ${DatabaseCreator.isArchived} = 0''';

    List<dynamic> params = [
      disciplina.nome,
      formatarData(dataRevisao)
    ];

    final data = await db.rawQuery(sql, params);

    List<Revisao> revisoes = List();

    for (final node in data) {
      final revisao = Revisao.fromJson(node);
      revisoes.add(revisao);
    }
    // print(revisoes.length);
    return revisoes;
  }

  static Future<void> addRevisao(Revisao revisao) async {

    final sql = '''INSERT INTO ${DatabaseCreator.revisaoTable}
    (
      ${DatabaseCreator.disciplina},
      ${DatabaseCreator.frequencia},
      ${DatabaseCreator.nome},
      ${DatabaseCreator.vezesRevisadas},
      ${DatabaseCreator.dataCadastro},
      ${DatabaseCreator.proxRevisao},
      ${DatabaseCreator.isArchived}
    )
    VALUES (?,?,?,?,?,?,?)''';
    List<dynamic> params = [
      revisao.disciplina,
      revisao.frequencia,
      revisao.nome,
      revisao.vezesRevisadas,
      formatarData(revisao.dataCadastro),
      formatarData(revisao.proxRevisao),
      revisao.isArchived ? 1 : 0,
    ];
    final result = await db.rawInsert(sql, params);
  }

  static Future<void> deleteRevisao(Revisao revisao) async {

    final sql = '''DELETE FROM ${DatabaseCreator.revisaoTable}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [revisao.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<void> updateRevisao(Revisao revisao) async {

    final sql = '''UPDATE ${DatabaseCreator.revisaoTable}
    SET ${DatabaseCreator.disciplina} = ?,
    ${DatabaseCreator.frequencia} = ?,
    ${DatabaseCreator.nome} = ?,
    ${DatabaseCreator.vezesRevisadas} = ?,
    ${DatabaseCreator.dataCadastro} = ?,
    ${DatabaseCreator.proxRevisao} = ?,
    ${DatabaseCreator.isArchived} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [
      revisao.disciplina,
      revisao.frequencia,
      revisao.nome,
      revisao.vezesRevisadas,
      formatarData(revisao.dataCadastro),
      formatarData(revisao.proxRevisao),
      revisao.isArchived ? 1 : 0,
      revisao.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<int> revisoesCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.revisaoTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }

  static String formatarData (DateTime data){
    return DateFormat('yyyy-MM-dd').format(data);
  }
}