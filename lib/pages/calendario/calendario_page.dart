import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/provider/lista_revisoes_model.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/ListarRevisoes.dart';
import 'package:revisao_estudos/pages/calendario/widget/seletorData/seletor_data.dart';
import 'package:revisao_estudos/pages/revisoes/adicionarRevisao/adicinar_revisao_page.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdicionarRevisaoPage(),
              ),
            ).then((value) {
              if(value){
                setState(() {});
              }
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        child: ChangeNotifierProvider(
          create: (context) => ListaRevisoesModel(),
          child: Column(
            children: [
              SeletorData(),
              Expanded(
                child: ListarRevisoes(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
