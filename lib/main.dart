
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/controllers/log_revisao_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';
import 'package:revisao_estudos/models/classes/log_revisao.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'database/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    imprimeBancoDeDados();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
      title: 'Revisão de Estudos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarioPage(),
    );
  }

  imprimeBancoDeDados() async {
    List<Frequencia> frequencias = await FrequenciaController.obterTodasFrequencias();
    List<Disciplina> disciplinas = await DisciplinaController.obterTodasDisciplinas();
    List<Revisao> revisoes = await RevisaoController.obterTodasRevisoes();
    List<LogRevisao> logRevisoes = await LogRevisaoController.obterTodosLogRevisoes();

    var item;
    print('\nFREQUENCIAS');
    for(item in frequencias){
      print(item.toString());
    }

    print('\nDISCIPLINAS');
    for(item in disciplinas){
      print(item.toString());
    }

    print('\nREVISOES');
    for(item in revisoes){
      print(item.toString());
    }

    print('\nLOG-REVISOES');
    for(item in logRevisoes){
      print(item.toString());
    }
  }
}