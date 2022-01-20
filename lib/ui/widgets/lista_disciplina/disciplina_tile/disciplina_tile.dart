import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/widgets/expansion_card/expansion_card_widget.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/lista_revisoes.dart';

class DisciplinaTile extends StatelessWidget {
  final Disciplina disciplina;
  final bool isCalendario;

  const DisciplinaTile({
    Key? key,
    required this.disciplina,
    required this.isCalendario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: disciplina.nome,
      initiallyExpanded: true,
      child: ListaRevisoes(
        revisoes: disciplina.revisoes ?? [],
        isCalendario: isCalendario,
      ),
    );
  }
}
