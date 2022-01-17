import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/tiles_widgets/log_tile.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/tiles_widgets/revisao_tile.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class ListaRevisoes extends StatelessWidget {
  final Disciplina disciplina;

  const ListaRevisoes({
    Key? key,
    required this.disciplina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime data = context.read<DataSelecionada>().dataSelecionada;
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    List<Revisao> revisoes = [];
    return FutureBuilder(
      future: repositoryRevisao.obterParaCaledario(disciplina, data),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          revisoes = snapshot.data as List<Revisao>? ?? [];
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: revisoes.length,
            itemBuilder: (context, index) => DateHelper.isLog(data)
                ? LogTile(
                    revisao: revisoes[index],
                  )
                : RevisaoTile(
                    revisao: revisoes[index],
                  ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
