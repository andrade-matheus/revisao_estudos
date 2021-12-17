import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';
import 'package:revisao_estudos/widgets/date_picker/date_picker.dart';

class SeletorData extends StatefulWidget {
  @override
  _SeletorDataState createState() => _SeletorDataState();
}

class _SeletorDataState extends State<SeletorData> {
  @override
  Widget build(BuildContext context) {
    DateTime dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => context.read<DataSelecionada>().reduzirUmDia(),
            child: Icon(Icons.arrow_back_outlined),
          ),
          ElevatedButton(
            onPressed: () async {
              var data = await escolherDataDialog(context, dataSelecionada);
              context.read<DataSelecionada>().defineData(data);
            },
            child: Text(DateHelper.botaoDataToString(dataSelecionada)),
          ),
          ElevatedButton(
            onPressed: () => context.read<DataSelecionada>().aumentarUmDia(),
            child: Icon(Icons.arrow_forward_outlined),
          ),
        ],
      ),
    );
  }
}
