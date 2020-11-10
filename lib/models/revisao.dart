import 'package:revisao_estudos/database/database_creator.dart';

class Revisao {
  int id;
  String disciplina;
  String frequencia;
  String nome;
  int vezesRevisadas;
  DateTime dataCadastro;
  DateTime proxRevisao;
  bool isArchived;

  Revisao(this.id,
      this.disciplina,
      this.frequencia,
      this.nome,
      this.dataCadastro,
      this.proxRevisao,
      this.vezesRevisadas,
      this.isArchived);

  Revisao.fromJson(dynamic json) {
    this.id = json[DatabaseCreator.id];
    this.disciplina = json[DatabaseCreator.disciplina];
    this.frequencia = json[DatabaseCreator.frequencia];
    this.nome = json[DatabaseCreator.nome];
    this.dataCadastro = DateTime.parse(json[DatabaseCreator.dataCadastro]);
    this.proxRevisao = DateTime.parse(json[DatabaseCreator.proxRevisao]);
    this.vezesRevisadas = json[DatabaseCreator.vezesRevisadas];
    this.isArchived = json[DatabaseCreator.isArchived] == 1;
  }
}