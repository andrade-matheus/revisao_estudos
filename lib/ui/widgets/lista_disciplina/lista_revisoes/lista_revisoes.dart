import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'log_tile/log_tile.dart';
import 'revisao_tile_calendario/revisao_tile_calendario.dart';
import 'revisao_tile_revisoes/revisao_nome.dart';
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
            return LogTile(revisao: revisao);
          } else {
            return RevisaoTileCalendario(
              revisao: revisoes[index],
              last: revisoes.length - 1 == index,
              first: index == 0,
            );
          }
        } else {
          return RevisaoTileRevisoes(revisao: revisao);
        }
      },
    );
  }
}
