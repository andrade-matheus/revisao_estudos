import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_disciplina_widget/disciplina_tile/disciplina_tile.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/sem_revisoes/sem_revisoes.dart';

class ListaDisciplina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    List<Disciplina> disciplinas = [];
    return Expanded(
      child: FutureBuilder(
        future: repositoryDisciplina.obterTodasComRevisoesPorData(dataSelecionada),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            disciplinas = (snapshot.data ?? []) as List<Disciplina>? ?? [];
            if (disciplinas.isEmpty) {
              return SemRevisoes();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 80),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: disciplinas.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = disciplinas[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: DisciplinaTile(disciplina: disciplina),
                  );
                },
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
