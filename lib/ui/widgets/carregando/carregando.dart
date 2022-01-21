import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class Carregando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.laranjaCarregando,
      ),
    );
  }
}
