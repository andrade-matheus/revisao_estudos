import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';

class RepositoryLogRevisao extends RepositoryCommon<LogRevisao> {
  @override
  String get nomeTabela => "logRevisao";

  @override
  Function get fromMap => LogRevisao.fromMap;
}
