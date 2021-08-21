import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';

abstract class EntityCommon {
  int id;

  static fromMap<T>(Map<String, dynamic> json) {
    if (T is Disciplina) {
      return Disciplina.fromMap(json);
    } else if (T is Frequencia) {
      return Frequencia.fromMap(json);
    } else if (T is LogRevisao) {
      return LogRevisao.fromMap(json);
    } else if (T is Revisao) {
      return Revisao.fromMap(json);
    } else {
      throw TypeError();
    }
  }

  Map<String, dynamic> toMap();
}
