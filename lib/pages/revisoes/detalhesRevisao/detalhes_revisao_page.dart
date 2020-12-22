import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/revisoes/detalhesRevisao/widget/detalhes_card.dart';

class DetalhesRevisaoPage extends StatefulWidget {
  final Revisao revisao;

  const DetalhesRevisaoPage(this.revisao);

  @override
  _DetalhesRevisaoPageState createState() => _DetalhesRevisaoPageState();
}

class _DetalhesRevisaoPageState extends State<DetalhesRevisaoPage> {
  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Detalhes da Revisão",
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      child: Column(
        children: [
          DetalhesCard(
            title: "Disciplina: ",
            text: this.widget.revisao.disciplina.nome,
          ),
          DetalhesCard(
            title: "Nome da revisão: ",
            text: this.widget.revisao.nome,
          ),
          DetalhesCard(
            title: "Frequência: ",
            text: this.widget.revisao.frequencia.frequencia,
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
      ),
    );
  }
}
