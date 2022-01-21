import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/ui/screens/revisao/detalhes_revisao_page/detalhes_card_widget/detalhes_card.dart';

class DetalhesRevisaoPage extends StatefulWidget {
  final Revisao revisao;

  const DetalhesRevisaoPage({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  _DetalhesRevisaoPageState createState() => _DetalhesRevisaoPageState();
}

class _DetalhesRevisaoPageState extends State<DetalhesRevisaoPage> {
  late Disciplina _disciplina;
  late Frequencia _frequencia;

  @override
  Future<void> initState() async {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
    _disciplina = (await repositoryDisciplina.obterPorId(widget.revisao.disciplinaId))!;
    _frequencia = (await repositoryFrequencia.obterPorId(widget.revisao.frequenciaId))!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetalhesCard(
          title: "Disciplina: ",
          text: _disciplina.nome,
        ),
        DetalhesCard(
          title: "Nome da revisão: ",
          text: widget.revisao.nome,
        ),
        DetalhesCard(
          title: "Frequência: ",
          text: _frequencia.frequencia,
        ),
        DetalhesCard(
          title: "Quantidade de revisões concluídas: ",
          text: widget.revisao.vezesRevisadas.toString(),
        ),
        DetalhesCard(
          title: "Data do cadastro: ",
          text: DateFormat('dd / MM / yyyy').format(widget.revisao.dataCadastro),
        ),
        DetalhesCard(
          title: "Data da próxima revisão: ",
          text: DateFormat('dd / MM / yyyy').format(widget.revisao.proxRevisao),
        ),
      ],
    );
  }
}
