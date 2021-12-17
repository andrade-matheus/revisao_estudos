import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
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

  Future<List<Disciplina>> obterTodasComRevisoesPorData(DateTime data) async {
    if (data.isBefore(DateHelper.hoje())) {
      return await obterTodasComLogRevisoesPorData(data);
    } else if (data.isAfter(DateHelper.amanha()) || data.isAtSameMomentAs(DateHelper.amanha())){
      return await _obterTodasComRevisoesPorData(data);
    } else {
      return await obterTodasComRevisoesParaHoje();
    }
  }

  // Retorna as disciplinas que tem Logs de Revisão para esse determinado dia.
  Future<List<Disciplina>> obterTodasComLogRevisoesPorData(DateTime data) async {
    String query = """SELECT DISTINCT disciplina.id, disciplina.nome
                      FROM logRevisao 
                      INNER JOIN revisao ON logRevisao.idRevisao = revisao.id
                      INNER JOIN disciplina ON revisao.idDisciplina = disciplina.id
                      WHERE date(logRevisao.dataRevisao) = date(?);
                      """;
    List<Object> arguments = [DateHelper.formatarParaSql(data)];
    return await obterPorRawQuery(query, arguments);
  }


  // Retorna as disciplinas que tem revisões para esse determinado dia e NÃO incluí as revisões atrasadas.
  Future<List<Disciplina>> _obterTodasComRevisoesPorData(DateTime data) async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) = date(?);
                      """;

    List<Object> arguments = [DateHelper.formatarParaSql(data)];
    return await obterPorRawQuery(query, arguments);
  }

  // Retorna disciplinas que tem revisões para hoje incluindo as atrasadas.
  Future<List<Disciplina>> obterTodasComRevisoesParaHoje() async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) < date(?);""";
    List<Object> arguments = [DateHelper.formatarParaSql(DateHelper.hoje())];
    return await obterPorRawQuery(query, arguments);
  }
}
