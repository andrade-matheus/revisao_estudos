import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/calendario_revisao_tile/calendario_revisao_tile.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/log_revisao_tile/log_revisao_tile.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class ListaRevisoes extends StatefulWidget {
  final Disciplina disciplina;
  final DateTime? data;

  const ListaRevisoes({
    Key? key,
    required this.disciplina,
    this.data,
  }) : super(key: key);

  @override
  State<ListaRevisoes> createState() => _ListaRevisoesState();
}

class _ListaRevisoesState extends State<ListaRevisoes> {
  RepositoryRevisao repositoryRevisao = RepositoryRevisao();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: repositoryRevisao.obterParaDisciplinaTile(
            widget.disciplina.id, widget.data),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Revisao> revisoes = snapshot.data as List<Revisao>;
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: revisoes.length,
                itemBuilder: (context, index) {
                  Revisao revisao = revisoes[index];

                  // Caso seja a tela de revisões e não a tela Calendário.
                  if (widget.data != null) {
                    DateTime data =
                        context.read<DataSelecionada>().dataSelecionada;
                    if (DateHelper.isLog(data)) {
                      return LogRevisaoTile(
                        revisao: revisao,
                        notifyParent: atualizar,
                      );
                    } else {
                      return CalendarioRevisaoTile(
                        revisao: revisao,
                        last: revisoes.length - 1 == index,
                        first: index == 0,
                      );
                    }
                  } else {
                    return LogRevisaoTile(
                      revisao: revisao,
                      notifyParent: atualizar,
                    );
                  }
                },
              );
            } else {
              // TODO: Criar widget 'Disciplina não possui revisões'
              return Container();
            }
          } else {
            return Carregando();
          }
        });
  }

  atualizar() {
    setState(() {});
  }
}
