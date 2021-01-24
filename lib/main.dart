import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
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
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // _iniciarNotificacoes();
  }

  _iniciarNotificacoes() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Vamos revisar !!!',
    'Veja quais são suas revisões para hoje!',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(
    android: AndroidNotificationDetails(
    'your channel id', 'your channel name', 'your channel description'),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
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
    List<Frequencia> frequencias =
        await FrequenciaController.obterTodasFrequencias();
    List<Disciplina> disciplinas =
        await DisciplinaController.obterTodasDisciplinas();
    List<Revisao> revisoes = await RevisaoController.obterTodasRevisoes();
    List<LogRevisao> logRevisoes =
        await LogRevisaoController.obterTodosLogRevisoes();

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
