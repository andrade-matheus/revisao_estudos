import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_page.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracoes_page.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/disciplinas_page.dart';
import 'package:revisao_estudos/ui/screens/frequencias/frequencias_page.dart';
import 'package:revisao_estudos/ui/screens/frequencias/tutorial_frequencias/tutorial_frequencias_page.dart';
import 'package:revisao_estudos/ui/screens/revisoes/adicionar_revisao_page/adicinar_revisao_page.dart';
import 'package:revisao_estudos/ui/screens/revisoes/detalhes_revisao_page/detalhes_revisao_page.dart';
import 'package:revisao_estudos/ui/screens/revisoes/revisoes_page.dart';
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
          name: 'CalendarioRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: CalendarioPage),
            AutoRoute(path: 'detalhesRevisao', page: DetalhesRevisaoPage),
            AutoRoute(path: 'adicionarRevisao', page: AdicionarRevisaoPage),
          ],
        ),
        AutoRoute(
          path: 'revisoes',
          name: 'RevisoesRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: RevisoesPage),
            AutoRoute(path: 'detalhesRevisao', page: DetalhesRevisaoPage),
            AutoRoute(path: 'adicionarRevisao', page: AdicionarRevisaoPage),
          ],
        ),
        AutoRoute(
          path: 'disciplinas',
          name: 'DisciplinasRouter',
          page: DisciplinasPage,
        ),
        AutoRoute(
          path: 'frequencia',
          name: 'FrequenciaRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: FrequenciasPage),
            AutoRoute(path: 'tutorialFrequencias', page: TutorialFrequenciasPage),
          ],
        ),
        AutoRoute(
          path: 'configuracoes',
          name: 'ConfiguracoesRouter',
          page: ConfiguracoesPage,
        ),
      ],
    )
  ],
)
class $AppRouter {}
