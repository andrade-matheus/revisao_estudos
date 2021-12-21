import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/lista_revisoes.dart';

class DisciplinaTile extends StatelessWidget {
  final Disciplina disciplina;
  final Widget child;

  const DisciplinaTile({
    Key key,
    this.child,
    @required this.disciplina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        disciplina.nome,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      children: [
        ListaRevisoes(
          disciplina: disciplina,
        ),
      ],
    );
  }
}
