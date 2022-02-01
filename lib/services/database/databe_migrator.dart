import 'package:revisao_estudos/services/database/comandos_sql.dart';

class DbMigrator {
  static final Map<int, String> migrations = {
    1: ComandosSQL.createTableDisciplina,
    2: ComandosSQL.createTableFrequencia,
    3: ComandosSQL.createTableRevisao,
    4: ComandosSQL.createTableLogRevisao,
    5: ComandosSQL.insertFrequenciasPadrao,
  };
}
