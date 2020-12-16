import 'package:intl/intl.dart';

class DatabaseController {

  // Tabelas
  static const disciplinaTable = 'disciplina';
  static const frequenciaTable = 'frequencia';
  static const revisaoTable = 'revisao';
  static const logRevisaoTable = 'logRevisao';

  // ID's (chaves estrangeiras)
  static const id = 'id';
  static const idDisciplina = 'idDisciplina';
  static const idFrequencia = 'idFrequencia';
  static const idRevisao = 'idRevisao';

  // Colunas de dados
  static const nome = 'nome';
  static const valorFrequencia = 'valorFrequencia';
  static const vezesRevisadas = 'vezesRevisadas';
  static const dataCadastro = 'dataCadastro';
  static const proxRevisao = 'proxRevisao';
  static const isArchived = 'isArchived';
  static const dataRevisao = 'dataRevisao';

  static String formatarData (DateTime data){
    return DateFormat('yyyy-MM-dd').format(data);
  }
}