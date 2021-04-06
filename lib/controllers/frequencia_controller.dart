import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:revisao_estudos/database/repository_service_frequencia.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';

class FrequenciaController {
  static frequenciaFromMap(Map<String, dynamic> map) {
    Frequencia frequencia = Frequencia(
      map[DatabaseController.id],
      map[DatabaseController.valorFrequencia],
    );
    return frequencia;
  }

  static Map<String, dynamic> frequenciaToMap(Frequencia frequencia) {
    var map = <String, dynamic>{
      DatabaseController.valorFrequencia: frequencia.frequencia,
    };
    return map;
  }

  // CONVERÕES DE / PARA JSON
  static Frequencia fromJson(Map<String, dynamic> json) {
    Frequencia frequencia = Frequencia(
      json['id'],
      json['frequencia'],
    );
    return frequencia;
  }

  Map<String, dynamic> toJson(Frequencia frequencia) {
    Map<String, dynamic> json = {
      'id': frequencia.id,
      'frequencia': frequencia.frequencia,
    };
    return json;
  }

  static obterTodasFrequencias() async {
    List<Frequencia> frequencias =
        await RepositoryServiceFrequencia.getAllFrequencias();
    return frequencias;
  }

  static obterFrequencia(int id) async {
    Frequencia frequencia = await RepositoryServiceFrequencia.getFrequencia(id);
    return frequencia;
  }

  static criarFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.insertFrequencia(frequencia);
  }

  static atualizarFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.updateFrequencia(frequencia);
  }

  static deletarFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.deleteFrequencia(frequencia);
  }
}
