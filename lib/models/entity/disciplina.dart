import 'package:revisao_estudos/models/interface/entity_common.dart';

class Disciplina extends EntityCommon {
  int id;
  String nome;

  Disciplina({
    this.id,
    this.nome,
  });

  static Disciplina fromMap(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
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

  bool operator ==(other) {
    if (this.nome == other.nome) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}
