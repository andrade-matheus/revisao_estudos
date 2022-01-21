import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class Revisao extends EntityCommon {
  int id;
  String nome;
  int disciplinaId;
  int frequenciaId;
  DateTime dataCadastro;
  DateTime proxRevisao;
  int vezesRevisadas;
  bool isArchived;

  Revisao({
    required this.id,
    required this.nome,
    required this.disciplinaId,
    required this.frequenciaId,
    required this.dataCadastro,
    required this.proxRevisao,
    required this.vezesRevisadas,
    required this.isArchived,
  });

  static Revisao fromMap(Map<String, dynamic> json) {
    return Revisao(
      id: json['id'] ?? json['idRevisao'],
      disciplinaId: json['idDisciplina'],
      frequenciaId: json['idFrequencia'],
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
      'idFrequencia': frequenciaId,
      'nome': nome,
      'dataCadastro': dataCadastro.toIso8601String(),
      'proxRevisao': proxRevisao.toIso8601String(),
      'vezesRevisadas': vezesRevisadas,
      'isArchived': isArchived ? 1 : 0,
    };
  }

  Future<void> realizarRevisao() async {
    RepositoryFrequencia repositoryFrequencia = new RepositoryFrequencia();
    Frequencia? frequencia =
        await repositoryFrequencia.obterPorId(this.frequenciaId);

    if (frequencia == null) {
      return;
    }

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
    repositoryRevisao.atualizar(this);

    LogRevisao novoLog = LogRevisao(
      id: 0,
      revisao: this,
      dataRevisao: DateHelper.hoje(),
    );
    RepositoryLogRevisao repositoryLogRevisao = RepositoryLogRevisao();
    repositoryLogRevisao.adicionar(novoLog);
  }

  @override
  String toString() {
    return '[${this.id}, ' +
        '${this.nome}, ' +
        '${this.disciplinaId}, ' +
        '${this.frequenciaId}, ' +
        '${this.dataCadastro}, ' +
        '${this.proxRevisao}, ' +
        '${this.vezesRevisadas}]';
  }
}
