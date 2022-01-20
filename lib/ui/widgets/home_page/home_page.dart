import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/ui/widgets/revisai_bottom_navigation_bar/revisai_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.branco,
        extendBody: true,
        routes: const [
          CalendarioRouter(),
          RevisoesRouter(),
          DisciplinasRouter(),
          FrequenciaRouter(),
          ConfiguracoesRouter()
        ],
        bottomNavigationBuilder: (_, tabsRouter) => RevisaiBottomNavigationBar(tabsRouter: tabsRouter),
      ),
    );
  }
}
