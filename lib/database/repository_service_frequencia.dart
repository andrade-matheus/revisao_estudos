
import 'database_creator.dart';
import 'package:revisao_estudos/models/frequencia.dart';

class RepositoryServiceFrequencia {
  static Future<List<Frequencia>> getAllFrequencias() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.frequenciaTable}
    WHERE ${DatabaseCreator.isArchived} = 0''';

    final data = await db.rawQuery(sql);

    List<Frequencia> frequencias = List();

    for (final node in data) {
      final frequencia = Frequencia.fromJson(node);
      frequencias.add(frequencia);
    }
    return frequencias;
  }

  static Future<Frequencia> getFrequencia(int id) async {

    final sql = '''SELECT * FROM ${DatabaseCreator.frequenciaTable}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final frequencia = Frequencia.fromJson(data.first);
    return frequencia;
  }

  static Future<void> addFrequencia(Frequencia frequencia) async {

    final sql = '''INSERT INTO ${DatabaseCreator.frequenciaTable}
    (
      ${DatabaseCreator.frequencia},
      ${DatabaseCreator.isArchived}
    )
    VALUES (?,?)''';
    List<dynamic> params = [frequencia.frequencia, frequencia.isArchived ? 1 : 0];
    final result = await db.rawInsert(sql, params);
  }

  static Future<void> deleteFrequencia(Frequencia frequencia) async {

    final sql = '''DELETE FROM ${DatabaseCreator.frequenciaTable}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [frequencia.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<void> updateFrequencia(Frequencia frequencia) async {

    final sql = '''UPDATE ${DatabaseCreator.frequenciaTable}
    SET ${DatabaseCreator.frequencia} = ?,
     ${DatabaseCreator.isArchived} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [frequencia.frequencia, frequencia.isArchived, frequencia.id];
    final result = await db.rawUpdate(sql, params);
  }

  static Future<int> frequenciasCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.frequenciaTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}