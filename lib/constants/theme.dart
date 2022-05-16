import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fontes.dart';

final revisaiTheme = ThemeData(
  primarySwatch: AppColors.primarySwatch,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: AppColors.branco,
    onBackground: AppColors.preto,
    error: AppColors.erro500,
    onError: AppColors.branco,
    primary: AppColors.laranja400,
    onPrimary: AppColors.branco,
    secondary: AppColors.laranja200,
    onSecondary: AppColors.preto,
    surface: AppColors.branco,
    onSurface: AppColors.preto,
  ),
  canvasColor: AppColors.branco,
  fontFamily: AppFontes.roboto,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
