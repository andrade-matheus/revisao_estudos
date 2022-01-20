import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/widgets/date_picker/date_picker.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class TextoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TituloPagina(titulo: 'Suas revisões'),
          ),
          GestureDetector(
            onTap: () async {
              var data = await escolherDataDialog(context, dataSelecionada);
              context.read<DataSelecionada>().defineData(data);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    AppIcons.calendarioPicker,
                    size: 20,
                  ),
                ),
                Text(
                  defineTexto(dataSelecionada),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
