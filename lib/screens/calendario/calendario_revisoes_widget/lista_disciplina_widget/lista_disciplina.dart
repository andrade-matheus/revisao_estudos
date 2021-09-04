import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/screens/calendario/calendario_revisoes_widget/sem_revisoes/sem_revisoes.dart';
import 'package:revisao_estudos/screens/calendario/calendario_revisoes_widget/tiles_widgets/disciplina_tile.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

class ListaDisciplina extends StatelessWidget {
  final List<Disciplina> disciplinas;

  const ListaDisciplina({Key key, this.disciplinas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    List<Disciplina> disciplinas = [];
    return FutureBuilder(
      future: repositoryDisciplina.obterTodosComRevisoesPorData(dataSelecionada),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          disciplinas = snapshot.data;
          if (disciplinas.isEmpty) {
            return SemRevisoes();
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: disciplinas.length,
              itemBuilder: (context, index) {
                Disciplina disciplina = disciplinas[index];
                return DisciplinaTile(disciplina: disciplina);
              },
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
