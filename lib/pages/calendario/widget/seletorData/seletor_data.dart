import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/provider/lista_revisoes_model.dart';

class SeletorData extends StatefulWidget {
  @override
  _SeletorDataState createState() => _SeletorDataState();
}

class _SeletorDataState extends State<SeletorData> {

  @override
  Widget build(BuildContext context) {
    var listaRevisoesState = Provider.of<ListaRevisoesModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            listaRevisoesState.dataSelecionada = listaRevisoesState.dataSelecionada.subtract(Duration(days: 1));
          },
          child: Icon(Icons.arrow_back_outlined),
        ),
        ElevatedButton(
          onPressed: () async {
            listaRevisoesState.dataSelecionada = await _escolherDataDialog(context, listaRevisoesState.dataSelecionada);
          },
          child: Text(botaoDataToString(listaRevisoesState.dataSelecionada)),
        ),
        ElevatedButton(
          onPressed: () {
            listaRevisoesState.dataSelecionada = listaRevisoesState.dataSelecionada.add(Duration(days: 1));
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
      locale : const Locale("pt"),
      context: context,
      initialDate: dataSelecionada,
      firstDate: new DateTime(1970, 8),
      lastDate: new DateTime(2101),
    );
    return dataEscolhida ?? dataSelecionada;
  }
}