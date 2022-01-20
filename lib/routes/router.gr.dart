// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i11;

import '../models/entity/revisao.dart' as _i12;
import '../ui/screens/calendario/calendario_page.dart' as _i5;
import '../ui/screens/configuracoes/configuracoes_page.dart' as _i4;
import '../ui/screens/disciplinas/disciplinas_page.dart' as _i3;
import '../ui/screens/frequencias/frequencias_page.dart' as _i9;
import '../ui/screens/frequencias/tutorial_frequencias/tutorial_frequencias_page.dart'
    as _i10;
import '../ui/screens/revisao/adicionar_revisao_page/adicinar_revisao_page.dart'
    as _i7;
import '../ui/screens/revisao/detalhes_revisao_page/detalhes_revisao_page.dart'
    as _i6;
import '../ui/screens/revisao/revisoes_page.dart' as _i8;
import '../ui/widgets/home_page/home_page.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CalendarioRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    RevisoesRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    DisciplinasRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.DisciplinasPage());
    },
    FrequenciaRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ConfiguracoesRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.ConfiguracoesPage());
    },
    CalendarioRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CalendarioPage());
    },
    DetalhesRevisaoRoute.name: (routeData) {
      final args = routeData.argsAs<DetalhesRevisaoRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.DetalhesRevisaoPage(key: args.key, revisao: args.revisao));
    },
    AdicionarRevisaoRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.AdicionarRevisaoPage());
    },
    RevisoesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.RevisoesPage());
    },
    FrequenciasRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.FrequenciasPage());
    },
    TutorialFrequenciasRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.TutorialFrequenciasPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(CalendarioRouter.name,
              path: 'calendario',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(CalendarioRoute.name,
                    path: '', parent: CalendarioRouter.name),
                _i2.RouteConfig(DetalhesRevisaoRoute.name,
                    path: 'detalhesRevisao', parent: CalendarioRouter.name),
                _i2.RouteConfig(AdicionarRevisaoRoute.name,
                    path: 'adicionarRevisao', parent: CalendarioRouter.name)
              ]),
          _i2.RouteConfig(RevisoesRouter.name,
              path: 'revisoes',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(RevisoesRoute.name,
                    path: '', parent: RevisoesRouter.name),
                _i2.RouteConfig(DetalhesRevisaoRoute.name,
                    path: 'detalhesRevisao', parent: RevisoesRouter.name),
                _i2.RouteConfig(AdicionarRevisaoRoute.name,
                    path: 'adicionarRevisao', parent: RevisoesRouter.name)
              ]),
          _i2.RouteConfig(DisciplinasRouter.name,
              path: 'disciplinas', parent: HomeRoute.name),
          _i2.RouteConfig(FrequenciaRouter.name,
              path: 'frequencia',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(FrequenciasRoute.name,
                    path: '', parent: FrequenciaRouter.name),
                _i2.RouteConfig(TutorialFrequenciasRoute.name,
                    path: 'tutorialFrequencias', parent: FrequenciaRouter.name)
              ]),
          _i2.RouteConfig(ConfiguracoesRouter.name,
              path: 'configuracoes', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class CalendarioRouter extends _i2.PageRouteInfo<void> {
  const CalendarioRouter({List<_i2.PageRouteInfo>? children})
      : super(CalendarioRouter.name,
            path: 'calendario', initialChildren: children);

  static const String name = 'CalendarioRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class RevisoesRouter extends _i2.PageRouteInfo<void> {
  const RevisoesRouter({List<_i2.PageRouteInfo>? children})
      : super(RevisoesRouter.name, path: 'revisoes', initialChildren: children);

  static const String name = 'RevisoesRouter';
}

/// generated route for
/// [_i3.DisciplinasPage]
class DisciplinasRouter extends _i2.PageRouteInfo<void> {
  const DisciplinasRouter()
      : super(DisciplinasRouter.name, path: 'disciplinas');

  static const String name = 'DisciplinasRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class FrequenciaRouter extends _i2.PageRouteInfo<void> {
  const FrequenciaRouter({List<_i2.PageRouteInfo>? children})
      : super(FrequenciaRouter.name,
            path: 'frequencia', initialChildren: children);

  static const String name = 'FrequenciaRouter';
}

/// generated route for
/// [_i4.ConfiguracoesPage]
class ConfiguracoesRouter extends _i2.PageRouteInfo<void> {
  const ConfiguracoesRouter()
      : super(ConfiguracoesRouter.name, path: 'configuracoes');

  static const String name = 'ConfiguracoesRouter';
}

/// generated route for
/// [_i5.CalendarioPage]
class CalendarioRoute extends _i2.PageRouteInfo<void> {
  const CalendarioRoute() : super(CalendarioRoute.name, path: '');

  static const String name = 'CalendarioRoute';
}

/// generated route for
/// [_i6.DetalhesRevisaoPage]
class DetalhesRevisaoRoute extends _i2.PageRouteInfo<DetalhesRevisaoRouteArgs> {
  DetalhesRevisaoRoute({_i11.Key? key, required _i12.Revisao revisao})
      : super(DetalhesRevisaoRoute.name,
            path: 'detalhesRevisao',
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
/// [_i7.AdicionarRevisaoPage]
class AdicionarRevisaoRoute extends _i2.PageRouteInfo<void> {
  const AdicionarRevisaoRoute()
      : super(AdicionarRevisaoRoute.name, path: 'adicionarRevisao');

  static const String name = 'AdicionarRevisaoRoute';
}

/// generated route for
/// [_i8.RevisoesPage]
class RevisoesRoute extends _i2.PageRouteInfo<void> {
  const RevisoesRoute() : super(RevisoesRoute.name, path: '');

  static const String name = 'RevisoesRoute';
}

/// generated route for
/// [_i9.FrequenciasPage]
class FrequenciasRoute extends _i2.PageRouteInfo<void> {
  const FrequenciasRoute() : super(FrequenciasRoute.name, path: '');

  static const String name = 'FrequenciasRoute';
}

/// generated route for
/// [_i10.TutorialFrequenciasPage]
class TutorialFrequenciasRoute extends _i2.PageRouteInfo<void> {
  const TutorialFrequenciasRoute()
      : super(TutorialFrequenciasRoute.name, path: 'tutorialFrequencias');

  static const String name = 'TutorialFrequenciasRoute';
}
