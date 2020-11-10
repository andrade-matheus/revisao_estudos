
import 'package:revisao_estudos/database/database_creator.dart';

class Disciplina {
  int id;
  String nome;
  bool isArchived;

  Disciplina(this.id, this.nome, this.isArchived);

  Disciplina.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.nome = json[DatabaseCreator.nome];
    this.isArchived = json[DatabaseCreator.isArchived] == 1;
  }

  @override
  String toString() {
    return this.nome;
  }

}

