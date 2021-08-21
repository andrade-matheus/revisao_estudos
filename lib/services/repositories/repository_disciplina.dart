import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryDisciplina extends RepositoryCommon {
  static Database _database;

  @override
  String get nomeTabela => "disciplina";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await DatabaseConfig.initDB();
    return _database;
  }

  Future<List<Disciplina>> getAllComRevisoesPorData(DateTime data) async {
    List<Disciplina> disciplinas = [];
    List<Revisao> revisoes = [];

    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    revisoes = await repositoryRevisao.getAllPorData(data);
    revisoes.forEach((element) => disciplinas.add(element.disciplina));

    return disciplinas;
  }
}
