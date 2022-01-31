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
  Future<bool> utilizado(int id) async {
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterPorDisciplina(id);
    return revisoes.isNotEmpty;
  }

  // Converte de JSON para lista de disciplinas instanciando suas revisões.
  Future<List<Disciplina>> fromMapListComRevisoes(List<Map<String, dynamic>>? param, DateTime? data, bool? atrasadas, bool? isLog) async {
    List<Disciplina> lista = [];
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();

    if (param != null && param.isNotEmpty) {
      for (var item in param) {
        lista.add(Disciplina.fromMapComRevisoes(
            item,
            await repositoryRevisao.obterParaDisciplina(
                item['id'], data, atrasadas, isLog)));
      }
    } else {
      lista = new List<Disciplina>.from([]);
    }

    lista.sort((a,b) => a.nome.compareTo(b.nome));

    return lista;
  }

  // Retorna todas as disciplinas e suas revisões instanciadas
  Future<List<Disciplina>> obterTodasInculindoRevisoes() async {
    final bd = await database;
    var resultado = await bd?.query(nomeTabela);
    List<Disciplina> disciplinas = await fromMapListComRevisoes(resultado, null, null, null);
    return disciplinas;
  }

  // Define qual método vai utilizar para enviar as disciplinas (com as suas devidas revisões) para o calendário.
  Future<List<Disciplina>> obterParaCalendario(DateTime data) async {
    if (data.isBefore(DateHelper.hoje())) {
      return await _obterTodasComLogRevisoesPorData(data);
    } else if (data.isAfter(DateHelper.amanha()) ||
        data.isAtSameMomentAs(DateHelper.amanha())) {
      return await _obterTodasComRevisoesPorData(data);
    } else {
      return await _obterTodasComRevisoesParaHoje();
    }
  }

  // Retorna as disciplinas que tem Logs de Revisão para esse determinado dia.
  Future<List<Disciplina>> _obterTodasComLogRevisoesPorData(DateTime data) async {
    String query = """SELECT DISTINCT disciplina.id, disciplina.nome
                      FROM logRevisao 
                      INNER JOIN revisao ON logRevisao.idRevisao = revisao.id
                      INNER JOIN disciplina ON revisao.idDisciplina = disciplina.id
                      WHERE date(logRevisao.dataRevisao) = date(?);
                      """;
    List<Object> arguments = [DateHelper.formatarParaSql(data)];

    final bd = await database;
    var resultado = await bd?.rawQuery(query, arguments);
    List<Disciplina> disciplinas = await fromMapListComRevisoes(resultado, data, false, true);
    return disciplinas;
  }

  // Retorna as disciplinas que tem revisões para esse determinado dia e NÃO incluí as revisões atrasadas.
  Future<List<Disciplina>> _obterTodasComRevisoesPorData(DateTime data) async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) = date(?);
                      """;
    List<Object> arguments = [DateHelper.formatarParaSql(data)];

    final bd = await database;
    var resultado = await bd?.rawQuery(query, arguments);
    List<Disciplina> disciplinas = await fromMapListComRevisoes(resultado, data, false, false);
    return disciplinas;
  }

  // Retorna disciplinas que tem revisões para hoje incluindo as atrasadas.
  Future<List<Disciplina>> _obterTodasComRevisoesParaHoje() async {
    String query = """SELECT DISTINCT disciplina.id as id, disciplina.nome as nome
                      FROM disciplina INNER JOIN revisao ON disciplina.id = revisao.idDisciplina
                      WHERE date(revisao.proxRevisao) < date(?);""";
    List<Object> arguments = [DateHelper.formatarParaSql(DateHelper.hoje())];

    final bd = await database;
    var resultado = await bd?.rawQuery(query, arguments);
    List<Disciplina> disciplinas = await fromMapListComRevisoes(resultado, DateHelper.hoje(), true, false);
    return disciplinas;
  }
}
