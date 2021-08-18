import 'package:dart_date/dart_date.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

class LogRevisao {
  int id;
  Revisao revisao;
  DateTime dataRevisao;

  LogRevisao({
    this.id,
    this.revisao,
    this.dataRevisao,
  });

  factory LogRevisao.fromMap(Map<String, dynamic> json) {
    RepositoryRevisao revisaoRepository = RepositoryRevisao();
    return LogRevisao(
      id: json['id'],
      revisao: revisaoRepository.getByIdSync(int.parse(json['revisao'])),
      dataRevisao: DateTime.parse(json['dataRevisao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'revisao': revisao,
      'dataRevisao': dataRevisao.toString(),
    };
  }

  @override
  String toString() {
    return '[${this.id}, ' + '${this.revisao.nome}, ' + '${this.dataRevisao}]';
  }
}
