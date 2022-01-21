import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

class RepositoryFrequencia extends RepositoryCommon<Frequencia> {
  @override
  String get nomeTabela => "frequencia";

  @override
  Function get fromMap => Frequencia.fromMap;

  @override
  Future<bool> utilizado(int id) async {
    RepositoryRevisao repositoryRevisao = new RepositoryRevisao();
    List<Revisao> revisoes = await repositoryRevisao.obterPorFrequencia(id);
    return revisoes.isNotEmpty;
  }
}
