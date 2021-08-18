import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';

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

  Revisao({
    this.id,
    this.nome,
    this.disciplina,
    this.frequencia,
    this.dataCadastro,
    this.proxRevisao,
    this.vezesRevisadas,
    this.isArchived,
  });

  factory Revisao.fromMap(Map<String, dynamic> json) {
    RepositoryDisciplina discRepository = RepositoryDisciplina();
    RepositoryFrequencia freqRepository = RepositoryFrequencia();
    return Revisao(
      id: json['id'],
      nome: json['nome'],
      disciplina: discRepository.getByIdSync(int.parse(json['disciplina'])),
      frequencia: freqRepository.getByIdSync(int.parse(json['frequencia'])),
      dataCadastro: DateTime.parse(json['dataCadastro']),
      proxRevisao: DateTime.parse(json['proxRevisao']),
      vezesRevisadas: int.parse(json['vezesRevisadas']),
      isArchived: json['isArchived'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'nome': nome,
      'disciplina': disciplina.id,
      'frequencia': frequencia.id,
      'dataCadastro': dataCadastro.toString(),
      'proxRevisao': proxRevisao.toString(),
      'vezesRevisadas': vezesRevisadas,
      'isArchived': isArchived,
    };
  }

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
