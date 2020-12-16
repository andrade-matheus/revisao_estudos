import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/provider/seletor_model.dart';

class SeletorData extends StatefulWidget {
  @override
  _SeletorDataState createState() => _SeletorDataState();
}

class _SeletorDataState extends State<SeletorData> {

  @override
  Widget build(BuildContext context) {
    var seletorData = Provider.of<SeletorDataModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            seletorData.dataSelecionada = seletorData.dataSelecionada.subtract(Duration(days: 1));
          },
          child: Icon(Icons.arrow_back_outlined),
        ),
        ElevatedButton(
          onPressed: () async {
            seletorData.dataSelecionada = await _escolherDataDialog(context, seletorData.dataSelecionada);
          },
          child: Text(botaoDataToString(seletorData.dataSelecionada)),
        ),
        ElevatedButton(
          onPressed: () {
            seletorData.dataSelecionada = seletorData.dataSelecionada.add(Duration(days: 1));
          },
          child: Icon(Icons.arrow_forward_outlined),
        ),
      ],
    );
  }

  String botaoDataToString(DateTime data) {
    return DateFormat.MMMMEEEEd('pt_BR').format(data);
  }

  Future<DateTime> _escolherDataDialog(BuildContext context, DateTime dataSelecionada) async {
    final DateTime dataEscolhida = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: new DateTime(1970, 8),
      lastDate: new DateTime(2101),
    );
    return dataEscolhida ?? dataSelecionada;
  }
}