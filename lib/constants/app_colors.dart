import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {

  // Extra
  static Color branco = Color(0xFFFFFFFF);
  static Color preto = Color(0xFF000000);
  static Color sombra = Colors.black12;

  // Bottom Navigation Bar
  static Color navBarItemLaranja = Color(0xFFFF9F41);
  static Color navBarItemCinza = Color(0xFF737373);
  static Color navBarDivisorCinza = Color(0xFFC4C4C4);

  // Laranjas
  static Color laranja = Color(0xFFFF7F00);
  static Color laranjaBordaCard = Color(0xFFFFCB99);

  // Legenda das revisões
  static Color vermelhoLegendaAtraso = Color(0xFFBE0000);
  static Color laranjaLegendaFrequencia = Color(0xFFFF9F41);

  // FloatingActionButton
  static Color laranjaFloatingActionButton = Color(0xFFFF9F41);

  // Carregando - ProgressIndicator
  static Color laranjaCarregando = Color(0xFFFF9F41);

  // Botões Nova Revisão
  static MaterialStateProperty<Color> botaoNovaRevisaoSalvar = MaterialStateProperty.all<Color>(Color(0xFFFF7F00));
  static MaterialStateProperty<Color> botaoNovaRevisaoCancelar = MaterialStateProperty.all<Color>(Color(0xFFBE0000));

  // TextField Nova Revisão
  static Color backgroundTextField = Color(0xFFF2F2F2);
  static Color bordaTextField = Color(0xFF797979);

  // TextField Nova/Editar Disciplina
  static Color underlinePadraoTextField = Color(0xFFFF9F41);
  static Color underlineErrorTextField = Color(0xFFBE0000);

  // Primary Swatch
  static MaterialColor primarySwatch = MaterialColor(
    laranja.value,
    <int, Color>{
      50: _tintColor(laranja, 0.9),
      100: _tintColor(laranja, 0.8),
      200: _tintColor(laranja, 0.6),
      300: _tintColor(laranja, 0.4),
      400: _tintColor(laranja, 0.2),
      500: laranja,
      600: _shadeColor(laranja, 0.1),
      700: _shadeColor(laranja, 0.2),
      800: _shadeColor(laranja, 0.3),
      900: _shadeColor(laranja, 0.4),
    },
  );

  static Color _tintColor(Color color, double factor) => Color.fromRGBO(
        _tintValue(color.red, factor),
        _tintValue(color.green, factor),
        _tintValue(color.blue, factor),
        1,
      );

  static int _tintValue(int value, double factor) => max(
        0,
        min(
          (value + ((255 - value) * factor)).round(),
          255,
        ),
      );

  static int _shadeValue(int value, double factor) => max(
        0,
        min(
          value - (value * factor).round(),
          255,
        ),
      );

  static Color _shadeColor(Color color, double factor) => Color.fromRGBO(
        _shadeValue(color.red, factor),
        _shadeValue(color.green, factor),
        _shadeValue(color.blue, factor),
        1,
      );
}
