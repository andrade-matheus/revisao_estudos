import 'package:revisao_estudos/database/database_creator.dart';

class Frequencia{
  int id;
  String frequencia;
  bool isArchived;

  Frequencia(this.id, this.frequencia, this.isArchived);

  Frequencia.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.frequencia = json[DatabaseCreator.frequencia];
    this.isArchived = json[DatabaseCreator.isArchived] == 1;
  }

}