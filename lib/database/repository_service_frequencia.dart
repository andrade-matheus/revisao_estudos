import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/database/database_creator.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';

class RepositoryServiceFrequencia {
  static Future<List<Frequencia>> getAllFrequencias() async {
    List<Map> maps = await db.query(
      DatabaseController.frequenciaTable,
      columns: [DatabaseController.id, DatabaseController.valorFrequencia],
    );

    List<Frequencia> frequencias = List();
    Map item;

    for (item in maps) {
      frequencias.add(FrequenciaController.frequenciaFromMap(item));
    }
    return frequencias;
  }

  static Future<Frequencia> getFrequencia(int id) async {
    List<Map> maps = await db.query(DatabaseController.frequenciaTable,
        columns: [DatabaseController.id, DatabaseController.valorFrequencia],
        where: '${DatabaseController.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return FrequenciaController.frequenciaFromMap(maps.first);
    }
    return null;
  }

  static Future<int> insertFrequencia(Frequencia frequencia) async {
    return await db.insert(DatabaseController.frequenciaTable, FrequenciaController.frequenciaToMap(frequencia));
  }

  static Future<int> deleteFrequencia(Frequencia frequencia) async {
    return await db.delete(DatabaseController.frequenciaTable,
        where: '${DatabaseController.id} = ?', whereArgs: [frequencia.id]);
  }

  static Future<int> updateFrequencia(Frequencia frequencia) async {
    return await db.update(DatabaseController.frequenciaTable, FrequenciaController.frequenciaToMap(frequencia),
        where: '${DatabaseController.id} = ?', whereArgs: [frequencia.id]);
  }
}
