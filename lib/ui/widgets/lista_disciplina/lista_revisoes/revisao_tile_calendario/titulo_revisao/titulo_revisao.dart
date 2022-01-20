import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class TitutoRevisao extends StatelessWidget {
  final String nomeRevisao;

  const TitutoRevisao({Key? key, required this.nomeRevisao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      nomeRevisao,
      style: TextStyle(
        color: AppColors.preto,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
