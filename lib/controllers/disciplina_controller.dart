import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/log_revisao_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/database/repository_service_disciplina.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class DisciplinaController{
  static Disciplina disciplinaFromMap(Map<String, dynamic> map) {
    Disciplina disciplina = Disciplina(
        map[DatabaseController.id],
        map[DatabaseController.nome]
    );
    return disciplina;
  }

  static Map<String, dynamic> disciplinaToMap(Disciplina disciplina) {
    var map = <String, dynamic>{
      DatabaseController.nome: disciplina.nome,
    };
    return map;
  }

  // CONVERÕES DE / PARA JSON
  static Disciplina fromJson(Map<String, dynamic> json) {
    Disciplina disciplina = Disciplina(
        json['id'],
        json['nome'],
    );
    return disciplina;
  }

  Map<String, dynamic> toJson(Disciplina disciplina) {
    Map<String, dynamic> json = {
      'id': disciplina.id,
      'nome': disciplina.nome,
    };
    return json;
  }

  static obterTodasDisciplinas() async {
    List<Disciplina> disciplinas = await RepositoryServiceDisciplina.getAllDisciplinas();
    disciplinas.sort((a,b) => a.nome.compareTo(b.nome));
    return disciplinas;
  }

  static obterTodasDisciplinasAtivasPorData(DateTime data) async {
    List<Revisao> revisoes = await RevisaoController.obterTodasRevisoesPorData(data);
    List<LogRevisao> logRevisoes = await LogRevisaoController.obterTodosLogRevisoesPorData(data);
    List<Disciplina> disciplinas = [];

    // TODO: otimizar os for's

    for (final item in revisoes) {
      if(!disciplinas.contains(item.disciplina)){
        disciplinas.add(item.disciplina);
      }
    }

    for (final item in logRevisoes) {
      if(!disciplinas.contains(item.revisao.disciplina)){
        disciplinas.add(item.revisao.disciplina);
      }
    }

    return disciplinas;
  }

  static obterTodasDisciplinasDeRevisoes(List<Revisao> revisoes) {
    List<Disciplina> disciplinas = [];

    for (final item in revisoes) {
      if(!disciplinas.contains(item.disciplina)){
        disciplinas.add(item.disciplina);
      }
    }

    disciplinas.sort((a,b) => a.nome.compareTo(b.nome));
    return disciplinas;
  }

  static obterDisciplina(int id) async{
    Disciplina disciplina = await RepositoryServiceDisciplina.getDisciplina(id);
    return disciplina;
  }

  static criarDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.insertDisciplina(disciplina);
  }

  static atualizarDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.updateDisciplina(disciplina);
  }

  static deletarDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.deleteDisciplina(disciplina);
  }
}