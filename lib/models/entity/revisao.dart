import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class Revisao extends EntityCommon {
  int id;
  String nome;
  Disciplina disciplina;
  Frequencia frequencia;
  DateTime dataCadastro;
  DateTime proxRevisao;
  int vezesRevisadas;
  bool isArchived;

  Revisao({
    this.id,
    this.nome,
    this.disciplina,
    this.frequencia,
    this.dataCadastro,
    this.proxRevisao,
    this.vezesRevisadas,
    this.isArchived,
  });

  static Future<Revisao> fromMap(Map<String, dynamic> json) async {
    RepositoryDisciplina discRepository = RepositoryDisciplina();
    RepositoryFrequencia freqRepository = RepositoryFrequencia();
    return Revisao(
      id: json['id'],
      disciplina: await discRepository.obterPorId(json['idDisciplina']),
      frequencia: await freqRepository.obterPorId(json['idFrequencia']),
      nome: json['nome'],
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
      'idDisciplina': disciplina.id,
      'idFrequencia': frequencia.id,
      'nome': nome,
      'dataCadastro': dataCadastro.toIso8601String(),
      'proxRevisao': proxRevisao.toIso8601String(),
      'vezesRevisadas': vezesRevisadas,
      'isArchived': isArchived ? 1 : 0,
    };
  }

  void realizarRevisao() {
    List<String> valoresFrequencia = frequencia.frequencia.split('-');
    int quantidadeFrequencias = valoresFrequencia.length;
    int diasProxRevisao;

    vezesRevisadas += 1;

    if (vezesRevisadas >= quantidadeFrequencias) {
      diasProxRevisao = int.parse(valoresFrequencia[quantidadeFrequencias - 1]);
    } else {
      diasProxRevisao = int.parse(valoresFrequencia[vezesRevisadas]);
    }

    proxRevisao = DateHelper.hoje.add(Duration(days: diasProxRevisao));
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    repositoryRevisao.atualizar(this);

    LogRevisao novoLog = LogRevisao(
      id: 0,
      revisao: this,
      dataRevisao: DateHelper.hoje,
    );
    RepositoryLogRevisao repositoryLogRevisao = RepositoryLogRevisao();
    repositoryLogRevisao.adicionar(novoLog);
  }

  @override
  String toString() {
    return '[${this.id}, ' +
        '${this.nome}, ' +
        '${this.disciplina.nome}, ' +
        '${this.frequencia.frequencia}, ' +
        '${this.dataCadastro}, ' +
        '${this.proxRevisao}, ' +
        '${this.vezesRevisadas}]';
  }
}
