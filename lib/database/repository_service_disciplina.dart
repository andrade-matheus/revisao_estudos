
import 'database_creator.dart';
import 'package:revisao_estudos/models/disciplina.dart';

class RepositoryServiceDisciplina {
  static Future<List<Disciplina>> getAllDisciplinas() async {

    final sql = '''SELECT * FROM ${DatabaseCreator.disciplinaTable}
    WHERE ${DatabaseCreator.isArchived} = 0''';

    final data = await db.rawQuery(sql);

    List<Disciplina> disciplinas = List();

    for (final node in data) {
      final disciplina = Disciplina.fromJson(node);
      disciplinas.add(disciplina);
    }

    return disciplinas;
  }

  static Future<Disciplina> getDisciplina(int id) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.disciplinaTable}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final disciplina = Disciplina.fromJson(data.first);
    return disciplina;
  }

  static Future<void> addDisciplina(Disciplina disciplina) async {

    final sql = '''INSERT INTO ${DatabaseCreator.disciplinaTable}
    (
      ${DatabaseCreator.nome},
      ${DatabaseCreator.isArchived}
    )
    VALUES (?,?)''';
    List<dynamic> params = [disciplina.nome, disciplina.isArchived ? 1 : 0];
    final result = await db.rawInsert(sql, params);
  }

  static Future<void> deleteDisciplina(Disciplina disciplina) async {

    final sql = '''DELETE FROM ${DatabaseCreator.disciplinaTable}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [disciplina.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<void> updateDisciplina(Disciplina disciplina) async {

    final sql = '''UPDATE ${DatabaseCreator.disciplinaTable}
    SET ${DatabaseCreator.nome} = ?,
    ${DatabaseCreator.isArchived} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [disciplina.nome, disciplina.isArchived,disciplina.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<int> disciplinasCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.disciplinaTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}