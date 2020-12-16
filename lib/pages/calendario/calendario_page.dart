import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/provider/seletor_model.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/ListarRevisoes.dart';
import 'package:revisao_estudos/pages/calendario/widget/seletorData/seletor_data.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime dataSelecionada = DateTime.now();
  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: PlanoDeFundo(
        title: "Calendário",
        child: ChangeNotifierProvider(
          create: (context) => new SeletorDataModel(),
          child: Column(
            children: [
              SeletorData(),
              ListarRevisoes(),
            ],
          ),
        ),
      ),
    );
  }
}
