import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_page.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracoes_page.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/disciplinas_page.dart';
import 'package:revisao_estudos/ui/screens/frequencias/frequencias_page.dart';
import 'package:revisao_estudos/ui/screens/frequencias/tutorial_frequencias/tutorial_frequencias_page.dart';
import 'package:revisao_estudos/ui/screens/revisao/adicionar_revisao/adicinar_revisao_page.dart';
import 'package:revisao_estudos/ui/screens/revisao/detalhes_revisao/detalhes_revisao_page.dart';
import 'package:revisao_estudos/ui/screens/revisao/revisoes_page.dart';
import 'package:revisao_estudos/ui/widgets/home_page/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'calendario',
          name: 'Calendario',
          page: CalendarioPage,
        ),
        AutoRoute(
          path: 'revisoes',
          name: 'Revisoes',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: RevisoesPage),
            AutoRoute(path: 'revisao', page: DetalhesRevisaoPage),
            AutoRoute(path: 'adicionarRevisao', page: AdicionarRevisaoPage),
          ],
        ),
        AutoRoute(
          path: 'disciplinas',
          name: 'Disciplinas',
          page: DisciplinasPage,
        ),
        AutoRoute(
          path: 'frequencia',
          name: 'Frequencia',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: FrequenciasPage),
            AutoRoute(path: 'tutorialFrequencias', page: TutorialFrequenciasPage),
          ],
        ),
        AutoRoute(
          path: 'configuracoes',
          name: 'Configuracoes',
          page: ConfiguracoesPage,
        ),
      ],
    )
  ],
)
class $AppRouter {}
