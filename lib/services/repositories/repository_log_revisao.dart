import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_common.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RepositoryLogRevisao extends RepositoryCommon<LogRevisao> {
  @override
  String get nomeTabela => "logRevisao";

  @override
  Function get fromMap => LogRevisao.fromMap;

  // Todas revisões para essa data incluindo as atrasadas.
  Future<List<LogRevisao>> obterTodosPorData(DateTime data) async {
    final bd = await database;
    var resultado = await bd?.query(
      nomeTabela,
      where: 'dataRevisao = ?',
      whereArgs: ["${DateHelper.formatarParaSql(data)}"],
    );
    return await fromMapList(resultado ?? []);
  }
}
