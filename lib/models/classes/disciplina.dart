import 'package:revisao_estudos/controllers/database_controller.dart';

class Disciplina {
  int id;
  String nome;

  Disciplina(
    this.id,
    this.nome,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseController.nome: nome,
    };
    return map;
  }

  Disciplina.fromMap(Map<String, dynamic> map) {
    this.id = map[DatabaseController.id];
    this.nome = map[DatabaseController.nome];
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