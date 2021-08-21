import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/log_revisao.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

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

  factory Revisao.fromMap(Map<String, dynamic> json) {
    RepositoryDisciplina discRepository = RepositoryDisciplina();
    RepositoryFrequencia freqRepository = RepositoryFrequencia();
    return Revisao(
      id: json['id'],
      nome: json['nome'],
      disciplina: discRepository.obterPorIdSync(int.parse(json['disciplina'])),
      frequencia: freqRepository.obterPorIdSync(int.parse(json['frequencia'])),
      dataCadastro: DateTime.parse(json['dataCadastro']),
      proxRevisao: DateTime.parse(json['proxRevisao']),
      vezesRevisadas: int.parse(json['vezesRevisadas']),
      isArchived: json['isArchived'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'nome': nome,
      'disciplina': disciplina.id,
      'frequencia': frequencia.id,
      'dataCadastro': dataCadastro.toString(),
      'proxRevisao': proxRevisao.toString(),
      'vezesRevisadas': vezesRevisadas,
      'isArchived': isArchived,
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

    proxRevisao.add(Duration(days: diasProxRevisao));
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    repositoryRevisao.atualizar(this);

    LogRevisao novoLog = LogRevisao(
      id: 0,
      revisao: this,
      dataRevisao: DateTime.now(),
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
