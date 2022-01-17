import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_page.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracoes_page.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/disciplinas_page.dart';
import 'package:revisao_estudos/ui/screens/frequencias/frequencias_page.dart';
import 'package:revisao_estudos/ui/screens/revisao/revisoes_page.dart';
import 'package:revisao_estudos/ui/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _index;
  final List<Widget> _widgetOptions = <Widget>[
    CalendarioPage(),
    RevisoesPage(),
    DisciplinasPage(),
    FrequenciasPage(),
    ConfiguracoesPage(),
  ];

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.branco,
        extendBody: true,
        bottomNavigationBar: BottomNavBar(atualizaIndex: atualizaIndex),
        body: _widgetOptions.elementAt(_index),
      ),
    );
  }

  void atualizaIndex(int index) {
    if (_index != index) {
      setState(() {
        _index = index;
      });
    }
  }
}
