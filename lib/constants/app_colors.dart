import 'package:flutter/material.dart';

class AppColors {
  static Color branco = Color(0xFFFFFFFF);
  static Color preto = Color(0xFF000000);
  static Color sombra = Colors.black12;
  static Color navBarItemLaranja = Color(0xFFFF9F41);
  static Color navBarItemCinza = Color(0xFF737373);
  static Color navBarDivisorCinza = Color(0xFFC4C4C4);
  static Color laranjaBordaCard = Color(0xFFFFCB99);
  static Color laranjaLegendaFrequencia = Color(0xFFFF9F41);
  static Color vermelhoLegendaAtraso = Color(0xFFBE0000);

  static MaterialColor primarySwatch = MaterialColor(
    0xFFFF9F41,
    <int, Color>{
      500: Color(0xFFFF7F00),
      400: Color(0xFFFF8F1F),
      300: Color(0xFFFF9F41),
      200: Color(0xFFFFAD5C),
      100: Color(0xFFFFCB99),
    },
  );
}
