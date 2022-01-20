import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetalhesCard(
          title: "Disciplina: ",
          text: this.widget.revisao.disciplina?.nome ?? '',
        ),
        DetalhesCard(
          title: "Nome da revisão: ",
          text: this.widget.revisao.nome,
        ),
        DetalhesCard(
          title: "Frequência: ",
          text: this.widget.revisao.frequencia?.frequencia ?? '',
        ),
        DetalhesCard(
          title: "Quantidade de revisões concluídas: ",
          text: this.widget.revisao.vezesRevisadas.toString(),
        ),
        DetalhesCard(
          title: "Data do cadastro: ",
          text: DateFormat('dd / MM / yyyy')
              .format(this.widget.revisao.dataCadastro),
        ),
        DetalhesCard(
          title: "Data da próxima revisão: ",
          text: DateFormat('dd / MM / yyyy')
              .format(this.widget.revisao.proxRevisao),
        ),
      ],
    );
  }
}
