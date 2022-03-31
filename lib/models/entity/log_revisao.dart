import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

class LogRevisao extends EntityCommon<LogRevisao> {
  int id;
  Revisao? revisao;
  DateTime dataRevisao;

  LogRevisao({
    required this.id,
    required this.revisao,
    required this.dataRevisao,
  });

  static Future<LogRevisao> fromMap(Map<String, dynamic> json) async {
    RepositoryRevisao revisaoRepository = RepositoryRevisao();
    return LogRevisao(
      id: json['id'],
      revisao: await revisaoRepository.getById(json['idRevisao']),
      dataRevisao: DateTime.parse(json['dataRevisao']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idRevisao': revisao?.id,
      'dataRevisao': dataRevisao.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '[${this.id}, ' + '${this.revisao?.nome}, ' + '${this.dataRevisao}]';
  }

  @override
  int compareTo(LogRevisao other) {
    if(revisao != null && other.revisao != null) {
      return revisao!.nome.compareTo(other.revisao!.nome);
    } else {
      return id.compareTo(other.id);
    }
  }
}
