import 'package:revisao_estudos/models/interface/entity_common.dart';

class Frequencia extends EntityCommon {
  int id;
  String frequencia;

  Frequencia({
    this.id,
    this.frequencia,
  });

  static Frequencia fromMap(Map<String, dynamic> json) {
    return Frequencia(
      id: json['id'],
      frequencia: json['valorFrequencia'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valorFrequencia': frequencia,
    };
  }

  @override
  String toString() {
    return this.frequencia;
  }
}
