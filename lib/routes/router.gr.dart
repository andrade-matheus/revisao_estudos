// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i11;

import '../models/entity/revisao.dart' as _i12;
import '../ui/screens/calendario/calendario_page.dart' as _i2;
import '../ui/screens/configuracoes/configuracoes_page.dart' as _i5;
import '../ui/screens/disciplinas/disciplinas_page.dart' as _i4;
import '../ui/screens/frequencias/frequencias_page.dart' as _i9;
import '../ui/screens/frequencias/tutorial_frequencias/tutorial_frequencias_page.dart'
    as _i10;
import '../ui/screens/revisao/adicionar_revisao/adicinar_revisao_page.dart'
    as _i8;
import '../ui/screens/revisao/detalhes_revisao/detalhes_revisao_page.dart'
    as _i7;
import '../ui/screens/revisao/revisoes_page.dart' as _i6;
import '../ui/widgets/home_page/home_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CalendarioRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.CalendarioPage());
    },
    RevisoesRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    DisciplinasRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.DisciplinasPage());
    },
    FrequenciaRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ConfiguracoesRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.ConfiguracoesPage());
    },
    RevisoesRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.RevisoesPage());
    },
    DetalhesRevisaoRoute.name: (routeData) {
      final args = routeData.argsAs<DetalhesRevisaoRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.DetalhesRevisaoPage(key: args.key, revisao: args.revisao));
    },
    AdicionarRevisaoRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.AdicionarRevisaoPage());
    },
    FrequenciasRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.FrequenciasPage());
    },
    TutorialFrequenciasRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.TutorialFrequenciasPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomeRoute.name, path: '/', children: [
          _i3.RouteConfig(CalendarioRouter.name,
              path: 'calendario', parent: HomeRoute.name),
          _i3.RouteConfig(RevisoesRouter.name,
              path: 'revisoes',
              parent: HomeRoute.name,
              children: [
                _i3.RouteConfig(RevisoesRoute.name,
                    path: '', parent: RevisoesRouter.name),
                _i3.RouteConfig(DetalhesRevisaoRoute.name,
                    path: 'revisao', parent: RevisoesRouter.name),
                _i3.RouteConfig(AdicionarRevisaoRoute.name,
                    path: 'adicionarRevisao', parent: RevisoesRouter.name)
              ]),
          _i3.RouteConfig(DisciplinasRouter.name,
              path: 'disciplinas', parent: HomeRoute.name),
          _i3.RouteConfig(FrequenciaRouter.name,
              path: 'frequencia',
              parent: HomeRoute.name,
              children: [
                _i3.RouteConfig(FrequenciasRoute.name,
                    path: '', parent: FrequenciaRouter.name),
                _i3.RouteConfig(TutorialFrequenciasRoute.name,
                    path: 'tutorialFrequencias', parent: FrequenciaRouter.name)
              ]),
          _i3.RouteConfig(ConfiguracoesRouter.name,
              path: 'configuracoes', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.CalendarioPage]
class CalendarioRouter extends _i3.PageRouteInfo<void> {
  const CalendarioRouter() : super(CalendarioRouter.name, path: 'calendario');

  static const String name = 'CalendarioRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class RevisoesRouter extends _i3.PageRouteInfo<void> {
  const RevisoesRouter({List<_i3.PageRouteInfo>? children})
      : super(RevisoesRouter.name, path: 'revisoes', initialChildren: children);

  static const String name = 'RevisoesRouter';
}

/// generated route for
/// [_i4.DisciplinasPage]
class DisciplinasRouter extends _i3.PageRouteInfo<void> {
  const DisciplinasRouter()
      : super(DisciplinasRouter.name, path: 'disciplinas');

  static const String name = 'DisciplinasRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class FrequenciaRouter extends _i3.PageRouteInfo<void> {
  const FrequenciaRouter({List<_i3.PageRouteInfo>? children})
      : super(FrequenciaRouter.name,
            path: 'frequencia', initialChildren: children);

  static const String name = 'FrequenciaRouter';
}

/// generated route for
/// [_i5.ConfiguracoesPage]
class ConfiguracoesRouter extends _i3.PageRouteInfo<void> {
  const ConfiguracoesRouter()
      : super(ConfiguracoesRouter.name, path: 'configuracoes');

  static const String name = 'ConfiguracoesRouter';
}

/// generated route for
/// [_i6.RevisoesPage]
class RevisoesRoute extends _i3.PageRouteInfo<void> {
  const RevisoesRoute() : super(RevisoesRoute.name, path: '');

  static const String name = 'RevisoesRoute';
}

/// generated route for
/// [_i7.DetalhesRevisaoPage]
class DetalhesRevisaoRoute extends _i3.PageRouteInfo<DetalhesRevisaoRouteArgs> {
  DetalhesRevisaoRoute({_i11.Key? key, required _i12.Revisao revisao})
      : super(DetalhesRevisaoRoute.name,
            path: 'revisao',
            args: DetalhesRevisaoRouteArgs(key: key, revisao: revisao));

  static const String name = 'DetalhesRevisaoRoute';
}

class DetalhesRevisaoRouteArgs {
  const DetalhesRevisaoRouteArgs({this.key, required this.revisao});

  final _i11.Key? key;

  final _i12.Revisao revisao;

  @override
  String toString() {
    return 'DetalhesRevisaoRouteArgs{key: $key, revisao: $revisao}';
  }
}

/// generated route for
/// [_i8.AdicionarRevisaoPage]
class AdicionarRevisaoRoute extends _i3.PageRouteInfo<void> {
  const AdicionarRevisaoRoute()
      : super(AdicionarRevisaoRoute.name, path: 'adicionarRevisao');

  static const String name = 'AdicionarRevisaoRoute';
}

/// generated route for
/// [_i9.FrequenciasPage]
class FrequenciasRoute extends _i3.PageRouteInfo<void> {
  const FrequenciasRoute() : super(FrequenciasRoute.name, path: '');

  static const String name = 'FrequenciasRoute';
}

/// generated route for
/// [_i10.TutorialFrequenciasPage]
class TutorialFrequenciasRoute extends _i3.PageRouteInfo<void> {
  const TutorialFrequenciasRoute()
      : super(TutorialFrequenciasRoute.name, path: 'tutorialFrequencias');

  static const String name = 'TutorialFrequenciasRoute';
}
