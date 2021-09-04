import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/screens/calendario/lista_revisoes_widget/revisoes_disciplina_widget/lista_revisoes_disciplina.dart';

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
        ListaRevisoesDisciplina(
          disciplina: disciplina,
        ),
      ],
    );
  }
}
