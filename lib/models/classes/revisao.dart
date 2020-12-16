import 'package:revisao_estudos/models/classes/disciplina.dart';

import 'frequencia.dart';

class Revisao {
  int id;
  String nome;
  Disciplina disciplina;
  Frequencia frequencia;
  DateTime dataCadastro;
  DateTime proxRevisao;
  int vezesRevisadas;
  bool isArchived;

  Revisao(
    this.id,
    this.nome,
    this.disciplina,
    this.frequencia,
    this.dataCadastro,
    this.proxRevisao,
    this.vezesRevisadas,
    this.isArchived,
  );

  // Map<String, dynamic> toMap() {
  //   var map = <String, dynamic>{
  //     DatabaseController.nome: nome,
  //     DatabaseController.idDisciplina: this.disciplina.id,
  //     DatabaseController.idFrequencia: this.frequencia.id,
  //     DatabaseController.dataCadastro: DatabaseController.formatarData(this.dataCadastro),
  //     DatabaseController.proxRevisao: DatabaseController.formatarData(this.proxRevisao),
  //     DatabaseController.vezesRevisadas: this.vezesRevisadas,
  //     DatabaseController.isArchived: isArchived ? 1 : 0,
  //   };
  //   return map;
  // }
  //
  // Revisao.fromMap(Map<String, dynamic> map) {
  //   this.id = map[DatabaseController.id];
  //   this.nome = map[DatabaseController.nome];
  //   this.disciplina = DisciplinaController.obterDisciplina(map[DatabaseController.idDisciplina]);
  //   this.frequencia = FrequenciaController.obterFrequencia(map[DatabaseController.idFrequencia]);
  //   this.dataCadastro = DateTime.parse(map[DatabaseController.dataCadastro]);
  //   this.proxRevisao = DateTime.parse(map[DatabaseController.proxRevisao]);
  //   this.isArchived = (map[DatabaseController.isArchived] == 0) ? false : true;
  // }

  @override
  String toString() {
    return '[${this.id}, ' +
        '${this.nome}, ' +
        '${this.disciplina.nome}, ' +
        '${this.frequencia.frequencia}, ' +
        '${this.dataCadastro}, ' +
        '${this.proxRevisao}, ' +
        '${this.vezesRevisadas}]';
  }
}