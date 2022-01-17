import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/constants/app_fontes.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class TextoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suas Revisões',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              fontFamily: AppFontes.robotoBold,
            ),
          ),
          Text(
            defineTexto(dataSelecionada),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppFontes.robotoBold,
            ),
          ),
        ],
      ),
    );
  }

  String defineTexto(DateTime data) {
    if (data == DateHelper.hoje()) {
      return 'Hoje';
    } else if (data == DateHelper.amanha()) {
      return 'Amanhã';
    } else if (data == DateHelper.ontem()) {
      return 'Ontem';
    } else {
      return DateHelper.formatarParaCalendario(data);
    }
  }
}
