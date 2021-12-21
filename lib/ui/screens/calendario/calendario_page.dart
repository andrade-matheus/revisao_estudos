import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_disciplina_widget/lista_disciplina.dart';
import 'package:revisao_estudos/ui/screens/calendario/seletor_data_widget/seletor_data.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';


class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime dataSelecionada = DateHelper.hoje();
  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataSelecionada()),
      ],
      child: Column(
        children: [
          SeletorData(),
          Expanded(
            child: ListaDisciplina(),
          ),
        ],
      ),
    );
  }
}
