import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:revisao_estudos/screens/calendario/calendario_page.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/notificacoes/controle_de_notificacoes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConfig.initDB();
  runApp(MyApp());
  //  F56D11 launcher icon hex collor
  //  FFC68D adaptive icon background hex collor
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    iniciarNotificacoes();
    agendarNotificacao();
  }

  @override
  Widget build(BuildContext context) {
    // imprimeBancoDeDados();
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
      debugShowCheckedModeBanner: false,
      home: CalendarioPage(),
    );
  }

  imprimeBancoDeDados() async {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    RepositoryLogRevisao repositoryLogRevisao = RepositoryLogRevisao();

    var frequencias = await repositoryFrequencia.obterTodos();
    var disciplinas = await repositoryDisciplina.obterTodos();
    var revisoes = await repositoryRevisao.obterTodos();
    var logRevisoes = await repositoryLogRevisao.obterTodos();

    var item;
    print('\nFREQUENCIAS');
    for (item in frequencias) {
      print(item.toString());
    }

    print('\nDISCIPLINAS');
    for (item in disciplinas) {
      print(item.toString());
    }

    print('\nREVISOES');
    for (item in revisoes) {
      print(item.toString());
    }

    print('\nLOG-REVISOES');
    for (item in logRevisoes) {
      print(item.toString());
    }
  }
}
