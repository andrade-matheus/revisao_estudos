import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/screens/calendario/lista_revisoes_widget/lista_disciplina_widget/lista_disciplinas.dart';
import 'package:revisao_estudos/screens/calendario/lista_revisoes_widget/sem_revisoes/sem_revisoes.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

class ListaRevisoes extends StatefulWidget {
  @override
  _ListaRevisoesState createState() => _ListaRevisoesState();
}

class _ListaRevisoesState extends State<ListaRevisoes> {
  @override
  Widget build(BuildContext context) {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    List<Disciplina> disciplinas = [];
    return FutureBuilder(
      future: repositoryDisciplina.getAllComRevisoesPorData(
          context.read<DataSelecionada>().dataSelecionada),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          disciplinas = snapshot.data;
          if (disciplinas.isEmpty) {
            return SemRevisoes();
          } else {
            return ListaDisciplinas(disciplinas: disciplinas);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
