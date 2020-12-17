import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';

class RepositoryServiceDisciplina {

  static Future<List<Disciplina>> getAllDisciplinas() async {
    List<Map> maps = await db.query(
      DatabaseController.disciplinaTable,
      columns: [
        DatabaseController.id,
        DatabaseController.nome,
      ],
    );

    List<Disciplina> disciplinas = List();
    Map item;

    for (item in maps) {
      disciplinas.add(DisciplinaController.disciplinaFromMap(item));
    }

    return disciplinas;
  }

  static Future<Disciplina> getDisciplina(int id) async {
    List<Map> maps = await db.query(DatabaseController.disciplinaTable,
        columns: [
          DatabaseController.id,
          DatabaseController.nome,
        ],
        where: '${DatabaseController.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return DisciplinaController.disciplinaFromMap(maps.first);
    }
    return null;
  }

  static Future<int> insertDisciplina(Disciplina disciplina) async {
    return await db.insert(
        DatabaseController.disciplinaTable, DisciplinaController.disciplinaToMap(disciplina));
  }

  static Future<int> deleteDisciplina(Disciplina disciplina) async {
    return await db.delete(DatabaseController.disciplinaTable,
        where: '${DatabaseController.id} = ?', whereArgs: [disciplina.id]);
  }

  static Future<int> updateDisciplina(Disciplina disciplina) async {
    return await db.update(
        DatabaseController.disciplinaTable, DisciplinaController.disciplinaToMap(disciplina),
        where: '${DatabaseController.id} = ?', whereArgs: [disciplina.id]);
  }
}
