import 'package:revisao_estudos/services/database/tables.dart';

class DbMigrator {
  static final Map<int, String> migrations = {
    1: Tables.createTableDisciplina,
    2: Tables.createTableFrequencia,
    3: Tables.createTableRevisao,
    4: Tables.createTableLogRevisao,
  };
}
