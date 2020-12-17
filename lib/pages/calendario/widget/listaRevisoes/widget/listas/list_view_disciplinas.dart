import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/listas/list_view_log.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/listas/list_view_revisoes.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/tiles/disciplina_tile.dart';

class ListaDeDisciplinas extends StatelessWidget {
  final List<Disciplina> disciplinas;
  final List<Revisao> revisoes;
  final bool isLog; // Define qual widget de listagem das revisões usar

  const ListaDeDisciplinas(
      {Key key, this.disciplinas, this.revisoes, this.isLog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: disciplinas.length,
      itemBuilder: (context, index) {
        Disciplina disciplina = disciplinas[index];
        List<Revisao> revisoesDisciplina = _revisoesDaDisciplina(disciplina, revisoes);
        Widget child;
        if (isLog) {
          child = ListaDeLogs(revisoes: revisoesDisciplina);
        } else {
          child = ListaDeRevisoes(revisoes: revisoesDisciplina);
        }
        return DisciplinaTile(
          title: disciplina.nome,
          child: child,
        );
      },
    );
  }

  // Filtrando as revisões que são da disciplina dada.
  List<Revisao> _revisoesDaDisciplina(Disciplina disciplina, List<Revisao> todasRevisoes){
    List<Revisao> revisoes = List();
    Revisao item;
    for(item in todasRevisoes){
      if(item.disciplina.id == disciplina.id){
        revisoes.add(item);
      }
    }
    return revisoes;
  }
}
