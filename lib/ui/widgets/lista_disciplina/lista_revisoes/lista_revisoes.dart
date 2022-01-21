import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/calendario_revisao_tile/calendario_revisao_tile.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/log_revisao_tile/log_revisao_tile.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class ListaRevisoes extends StatelessWidget {
  final List<Revisao> revisoes;
  final bool isCalendario;

  const ListaRevisoes({
    Key? key,
    required this.revisoes,
    required this.isCalendario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: revisoes.length,
      itemBuilder: (context, index) {
        Revisao revisao = revisoes[index];

        // Caso seja a tela de revisões e não a tela Calendário.
        if (isCalendario) {
          DateTime data = context.read<DataSelecionada>().dataSelecionada;
          if (DateHelper.isLog(data)) {
            return LogRevisaoTile(revisao: revisao);
          } else {
            return CalendarioRevisaoTile(
              revisao: revisoes[index],
              last: revisoes.length - 1 == index,
              first: index == 0,
            );
          }
        } else {
          return LogRevisaoTile(revisao: revisao);
        }
      },
    );
  }
}
