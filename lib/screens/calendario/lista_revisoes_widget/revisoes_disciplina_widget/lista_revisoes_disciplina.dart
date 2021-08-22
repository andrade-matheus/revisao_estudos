import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/screens/calendario/lista_revisoes_widget/tiles_widgets/revisao_tile.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

class ListaRevisoesDisciplina extends StatelessWidget {
  final Disciplina disciplina;

  const ListaRevisoesDisciplina({Key key, this.disciplina}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    List<Revisao> revisoes = [];
    return FutureBuilder(
      future: repositoryRevisao.obterTodosPorDisciplinaPorData(
        disciplina,
        context.read<DataSelecionada>().dataSelecionada,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          revisoes = snapshot.data;
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: revisoes.length,
            itemBuilder: (context, index) =>
                RevisaoTile(revisao: revisoes[index]),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
