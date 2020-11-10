
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'database/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revisão de Estudos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Revisão de Estudos home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return CalendarioPage();
  }
}
