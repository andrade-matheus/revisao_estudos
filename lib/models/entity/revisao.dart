import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class Revisao extends EntityCommon<Revisao> {
  int id;
  String nome;
  int disciplinaId;
  Frequencia frequencia;
  DateTime dataCadastro;
  DateTime proxRevisao;
  int vezesRevisadas;
  bool isArchived;

  Revisao({
    required this.id,
    required this.nome,
    required this.disciplinaId,
    required this.frequencia,
    required this.dataCadastro,
    required this.proxRevisao,
    required this.vezesRevisadas,
    required this.isArchived,
  });

  static Future<Revisao> fromMap(Map<String, dynamic> json) async {
    RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
    return Revisao(
      id: json['id'] ?? json['idRevisao'],
      disciplinaId: json['idDisciplina'],
      frequencia: (await repositoryFrequencia.getById(json['idFrequencia']))!,
      nome: json['nome'] ?? json['nomeRevisao'],
      dataCadastro: DateTime.parse(json['dataCadastro']),
      proxRevisao: DateTime.parse(json['proxRevisao']),
      vezesRevisadas: json['vezesRevisadas'],
      isArchived: json['isArchived'] != 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idDisciplina': disciplinaId,
      'idFrequencia': frequencia.id,
      'nome': nome,
      'dataCadastro': dataCadastro.toIso8601String(),
      'proxRevisao': proxRevisao.toIso8601String(),
      'vezesRevisadas': vezesRevisadas,
      'isArchived': isArchived ? 1 : 0,
    };
  }

  Future<void> realizarRevisao() async {
    List<String> valoresFrequencia = frequencia.frequencia.split('-');
    int quantidadeFrequencias = valoresFrequencia.length;
    int diasProxRevisao;

    vezesRevisadas += 1;

    if (vezesRevisadas >= quantidadeFrequencias) {
      diasProxRevisao = int.parse(valoresFrequencia[quantidadeFrequencias - 1]);
    } else {
      diasProxRevisao = int.parse(valoresFrequencia[vezesRevisadas]);
    }

    proxRevisao = DateHelper.hoje().add(Duration(days: diasProxRevisao));
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    repositoryRevisao.update(this);

    LogRevisao novoLog = LogRevisao(
      id: 0,
      revisao: this,
      dataRevisao: DateHelper.hoje(),
    );
    RepositoryLogRevisao repositoryLogRevisao = RepositoryLogRevisao();
    repositoryLogRevisao.add(novoLog);
  }

  @override
  String toString() {
    return '[${this.id}, ' +
        '${this.nome}, ' +
        '${this.disciplinaId}, ' +
        '${this.frequencia}, ' +
        '${this.dataCadastro}, ' +
        '${this.proxRevisao}, ' +
        '${this.vezesRevisadas}]';
  }

  @override
  int compareTo(Revisao other) {
    return nome.compareTo(other.nome);
  }
}
