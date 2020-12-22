import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/controllers/log_revisao_controller.dart';
import 'package:revisao_estudos/database/repository_service_revisao.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class RevisaoController {
  // CONSTRUTOR:
  static revisaoFromMap(Map<String, dynamic> map) async {
    Revisao revisao = Revisao(
      map[DatabaseController.id],
      map[DatabaseController.nome],
      await DisciplinaController.obterDisciplina(
          map[DatabaseController.idDisciplina]),
      await FrequenciaController.obterFrequencia(
          map[DatabaseController.idFrequencia]),
      DateTime.parse(map[DatabaseController.dataCadastro]),
      DateTime.parse(map[DatabaseController.proxRevisao]),
      map[DatabaseController.vezesRevisadas],
      (map[DatabaseController.isArchived] == 0) ? false : true,
    );

    return revisao;
  }

  static Map<String, dynamic> revisaoToMap(Revisao revisao) {
    var map = <String, dynamic>{
      DatabaseController.nome: revisao.nome,
      DatabaseController.idDisciplina: revisao.disciplina.id,
      DatabaseController.idFrequencia: revisao.frequencia.id,
      DatabaseController.dataCadastro: DatabaseController.formatarData(revisao.dataCadastro),
      DatabaseController.proxRevisao: DatabaseController.formatarData(revisao.proxRevisao),
      DatabaseController.vezesRevisadas: revisao.vezesRevisadas,
      DatabaseController.isArchived: revisao.isArchived ? 1 : 0,
    };
    return map;
  }

  // OBTER REVISÕES
  static obterTodasRevisoes() async {
    List<Revisao> revisoes = await RepositoryServiceRevisao.getAllRevisoes();
    return revisoes;
  }

  static obterTodasRevisoesParaHoje() async {
    List<Revisao> revisoes = await RepositoryServiceRevisao.getAllRevisoes();
    DateTime now = new DateTime.now().add(Duration(days: 1));
    DateTime amanha = new DateTime(now.year, now.month, now.day);

    List<Revisao> resultado = List();
    Revisao item;

    for(item in revisoes){
      if(item.proxRevisao.isBefore(amanha)){
        resultado.add(item);
      }
    }

    return resultado;
  }

  static obterTodasRevisoesPorDisciplina(Disciplina disciplina) async {
    List<Revisao> revisoes =
        await RepositoryServiceRevisao.getRevisoesByDisciplina(disciplina);
    return revisoes;
  }

  static obterTodasRevisoesPorData(DateTime data) async {
    List<Revisao> revisoes =
        await RepositoryServiceRevisao.getRevisoesByDate(data);
    return revisoes;
  }

  static obterTodasRevisoesPorDisciplinaEData(
      Disciplina disciplina, DateTime data) async {
    List<Revisao> revisoes =
        await RepositoryServiceRevisao.getRevisoesByDisciplinaAndDate(
            disciplina, data);

    return revisoes;
  }

  static obterRevisao(int id) async {
    Revisao revisao = await RepositoryServiceRevisao.getRevisao(id);
    return revisao;
  }

  // CRUD REVISÕES
  static criarRevisao(Revisao revisao) async {
    await RepositoryServiceRevisao.insertRevisao(revisao);
  }

  static atualizarRevisao(Revisao revisao) async {
    await RepositoryServiceRevisao.updateRevisao(revisao);
  }

  static deletarRevisao(Revisao revisao) async {
    await RepositoryServiceRevisao.deleteRevisao(revisao);
  }

  // FUNÇÕES AUXILIARES DAS REVISÕES:
  static Future<bool> realizarRevisao(Revisao revisao) async {
    List<String> valoresFrequencia = revisao.frequencia.frequencia.split('-');
    int quantidadeFrequencias = valoresFrequencia.length;
    int diasProxRevisao;

    revisao.vezesRevisadas += 1;

    if (revisao.vezesRevisadas >= quantidadeFrequencias) {
      diasProxRevisao = int.parse(valoresFrequencia[quantidadeFrequencias - 1]);
    } else {
      diasProxRevisao = int.parse(valoresFrequencia[revisao.vezesRevisadas]);
    }

    revisao.proxRevisao = revisao.proxRevisao.add(Duration(days: diasProxRevisao));
    await RevisaoController.atualizarRevisao(revisao);

    LogRevisao novoLog = LogRevisao(0, revisao, DateTime.now());
    await LogRevisaoController.criarLogRevisao(novoLog);
    return true;
  }
}
