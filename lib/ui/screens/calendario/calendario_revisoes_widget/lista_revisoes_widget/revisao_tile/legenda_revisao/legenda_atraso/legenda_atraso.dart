import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class LegendaAtraso extends StatelessWidget {
  final Revisao revisao;

  const LegendaAtraso({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int diasAtraso = _diasDeAtraso(revisao);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          AppIcons.setaAtraso,
          color: AppColors.vermelhoLegendaAtraso,
          size: 15,
        ),
        RichText(
          text: TextSpan(
            text: '$diasAtraso ${(diasAtraso > 1) ? 'dias' : 'dia'}',
            style: TextStyle(
                color: AppColors.vermelhoLegendaAtraso,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  int _diasDeAtraso(Revisao revisao) {
    return DateHelper.hoje().difference(revisao.proxRevisao).inDays;
  }
}
