import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryDisciplina extends RepositoryCommon<Disciplina> {
  @override
  String get nomeTabela => "disciplina";

  @override
  Function get fromMap => Disciplina.fromMap;

  @override
  Future<bool> utilizado(int id) async{
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterPorDisciplina(id);
    return revisoes.isNotEmpty;
  }
  
  @override
  Future<List<Disciplina>> obterTodos() async {
    final bd = await database;
    var resultado = await bd?.query(nomeTabela);

    List<Disciplina> disciplinas = await fromMapList(resultado ?? []);

    // Obtendo as revisões destas disciplinas.
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterTodos();

    disciplinas.forEach((disciplina) {
      disciplina.revisoes = revisoes.where((revisao) => disciplina.id == revisao.disciplina?.id).toList();
    });

    return disciplinas;
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
    List<Disciplina> disciplinas = await obterPorRawQuery(query, arguments);

    // Obtendo as revisões destas disciplinas.
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterTodasComLogRevisoesPorData(data);

    disciplinas.forEach((disciplina) {
      disciplina.revisoes = revisoes.where((revisao) => disciplina.id == revisao.disciplina?.id).toList();
    });

    return disciplinas;
  }


  // Retorna as disciplinas que tem revisões para esse determinado dia e NÃO incluí as revisões atrasadas.
  Future<List<Disciplina>> _obterTodasComRevisoesPorData(DateTime data) async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) = date(?);
                      """;
    List<Object> arguments = [DateHelper.formatarParaSql(data)];
    List<Disciplina> disciplinas = await obterPorRawQuery(query, arguments);

    // Obtendo as revisões destas disciplinas.
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterPorData(data);

    disciplinas.forEach((disciplina) {
      disciplina.revisoes = revisoes.where((revisao) => disciplina.id == revisao.disciplina?.id).toList();
    });

    return disciplinas;
  }

  // Retorna disciplinas que tem revisões para hoje incluindo as atrasadas.
  Future<List<Disciplina>> obterTodasComRevisoesParaHoje() async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) < date(?);""";
    List<Object> arguments = [DateHelper.formatarParaSql(DateHelper.hoje())];
    List<Disciplina> disciplinas = await obterPorRawQuery(query, arguments);

    // Obtendo as revisões destas disciplinas.
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterPorData(DateHelper.hoje());

    disciplinas.forEach((disciplina) {
      disciplina.revisoes = revisoes.where((revisao) => disciplina.id == revisao.disciplina?.id).toList();
    });

    return disciplinas;
  }
}
