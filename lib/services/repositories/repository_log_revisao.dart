import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';

class RepositoryLogRevisao extends RepositoryCommon<LogRevisao> {
  @override
  String get tableName => "logRevisao";

  @override
  Function get fromMap => LogRevisao.fromMap;

  @override
  Future<bool> isBeingUsed(int id) async {
    return true;
  }
}
