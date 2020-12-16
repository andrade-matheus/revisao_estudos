import 'package:revisao_estudos/models/classes/revisao.dart';

class LogRevisao {
  int id;
  Revisao revisao;
  DateTime dataRevisao;

  LogRevisao(this.id, this.revisao, this.dataRevisao);

  @override
  String toString() {
    return '[${this.id}, ' +
        '${this.revisao.nome}, ' +
        '${this.dataRevisao}]';
  }
}
