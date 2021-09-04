import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';

class RepositoryFrequencia extends RepositoryCommon<Frequencia> {
  @override
  String get nomeTabela => "frequencia";

  @override
  Function get fromMap => Frequencia.fromMap;
}
