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
    } else {
      var repository = RepositoryRevisao();
      var revisoes = await repository.obterPorDataParaCalendario(data);
      for (var rev in revisoes) {
        if (!disciplinas.contains(rev.disciplina)) {
          disciplinas.add(rev.disciplina);
        }
      }
    }

    return disciplinas;
  }
}
