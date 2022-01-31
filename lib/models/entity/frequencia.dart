import 'package:revisao_estudos/models/interface/entity_common.dart';

class Frequencia extends EntityCommon<Frequencia> {
  int id;
  String frequencia;

  Frequencia({
    required this.id,
    required this.frequencia,
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
    return this.frequencia.replaceAll('-', ' - ');
  }

  @override
  int compareTo(Frequencia other) {
    return frequencia.compareTo(other.frequencia);
  }
}
