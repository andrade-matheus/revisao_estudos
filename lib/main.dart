import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:revisao_estudos/constants/theme.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/services/database/database_config.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_log_revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/utils/notificacoes/controle_de_notificacoes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConfig.initDB();

  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;


  runApp(MyApp());
  //  F56D11 launcher icon hex collor
  //  FFC68D adaptive icon background hex collor
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    iniciarNotificacoes();
    agendarNotificacao();
  }

  @override
  Widget build(BuildContext context) {
    // imprimeBancoDeDados();
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
      theme: revisaiTheme,
      debugShowCheckedModeBanner: false,
      title: 'RevisAí',
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
    );
  }

  imprimeBancoDeDados() async {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
    RepositoryRevisao repositoryRevisao = RepositoryRevisao();
    RepositoryLogRevisao repositoryLogRevisao = RepositoryLogRevisao();

    var frequencias = await repositoryFrequencia.getAll();
    var disciplinas = await repositoryDisciplina.getAll();
    var revisoes = await repositoryRevisao.getAll();
    var logRevisoes = await repositoryLogRevisao.getAll();

    print('\nFREQUENCIAS');
    for (var item in frequencias) {
      print(item.toString());
    }

    print('\nDISCIPLINAS');
    for (var item in disciplinas) {
      print(item.toString());
    }

    print('\nREVISOES');
    for (var item in revisoes) {
      print(item.toString());
    }

    print('\nLOG-REVISOES');
    for (var item in logRevisoes) {
      print(item.toString());
    }
  }
}
