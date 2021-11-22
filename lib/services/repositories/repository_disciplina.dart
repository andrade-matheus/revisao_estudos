import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryDisciplina extends RepositoryCommon<Disciplina> {
  static Database _database;

  @override
  String get nomeTabela => "disciplina";

  @override
  Function get fromMap => Disciplina.fromMap;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<List<Disciplina>> obterTodosComRevisoesPorData(DateTime data) async {
    List<Disciplina> disciplinas = [];

    if (data.isBefore(DateHelper.hoje)) {
      var repository = RepositoryLogRevisao();
      var logRevisoes = await repository.obterTodosPorData(data);
      for (var logRev in logRevisoes) {
        if (!disciplinas.contains(logRev.revisao.disciplina)) {
          disciplinas.add(logRev.revisao.disciplina);
        }
      }
    } else if (data.isAfter(DateHelper.amanha) || data.isAtSameMomentAs(DateHelper.amanha)){
      disciplinas = await _obterTodosComRevisoesPorData(data);
    } else {
      disciplinas = await obterTodasComRevisoesParaHoje();
    }

    return disciplinas;
  }

  // Retorna as disciplinas que tem revisões para esse determinado dia e NÃO incluí as revisões atrasadas.
  Future<List<Disciplina>> _obterTodosComRevisoesPorData(DateTime data) async {
    List<Disciplina> disciplinas = [];

    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) = date(?);""";

    List<Object> arguments = [DateHelper.formatarParaSql(data)];

    disciplinas = await obterPorRawQuery(query, arguments);

    return disciplinas;
  }

  // Retorna disciplinas que tem revisões para hoje incluindo as atrasadas.
  Future<List<Disciplina>> obterTodasComRevisoesParaHoje() async {
    List<Disciplina> disciplinas = [];

    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) < date(?);""";
    List<Object> arguments = [DateHelper.formatarParaSql(DateHelper.hoje)];

    disciplinas = await obterPorRawQuery(query, arguments);

    return disciplinas;
  }
}
