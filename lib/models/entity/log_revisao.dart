import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

class LogRevisao extends EntityCommon {
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
      revisao: revisaoRepository.obterPorIdSync(int.parse(json['revisao'])),
      dataRevisao: DateTime.parse(json['dataRevisao']),
    );
  }

  @override
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
