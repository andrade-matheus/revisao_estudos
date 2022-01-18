import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/lista_revisoes.dart';
import 'package:revisao_estudos/ui/widgets/expansion_card/expansion_card_widget.dart';

class DisciplinaTile extends StatelessWidget {
  final Disciplina disciplina;

  const DisciplinaTile({
    Key? key,
    required this.disciplina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: disciplina.nome,
      initiallyExpanded: true,
      child: ListaRevisoes(
        disciplina: disciplina,
      ),
    );
  }
}
