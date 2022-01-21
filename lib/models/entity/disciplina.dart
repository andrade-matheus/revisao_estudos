import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';

class Disciplina extends EntityCommon {
  int id;
  String nome;
  List<Revisao>? revisoes;

  Disciplina({
    required this.id,
    required this.nome,
    this.revisoes,
  });

  static Disciplina fromMap(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
    );
  }

  static Disciplina fromMapComRevisoes(Map<String, dynamic> json, List<Revisao> revisoes) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
      revisoes: revisoes,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return this.nome;
  }

  @override
  bool operator ==(other) {
    return other is Disciplina && other.id == this.id;
  }

  @override
  int get hashCode => super.hashCode;
}
