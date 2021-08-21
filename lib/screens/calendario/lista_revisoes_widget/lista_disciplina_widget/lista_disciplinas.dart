import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/screens/calendario/lista_revisoes_widget/tiles_widgets/disciplina_tile.dart';

class ListaDisciplinas extends StatelessWidget {
  final List<Disciplina> disciplinas;

  const ListaDisciplinas({Key key, this.disciplinas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: disciplinas.length,
      itemBuilder: (context, index) {
        Disciplina disciplina = disciplinas[index];
        return DisciplinaTile(title: disciplina.nome);
      },
    );
  }
}
