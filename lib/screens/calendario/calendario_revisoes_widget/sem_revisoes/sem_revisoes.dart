import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class SemRevisoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        DateHelper.isLog(context.read<DataSelecionada>().dataSelecionada)
            ? "Não houve revisões realizadas neste dia."
            : "Sem revisões por hoje.",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
