import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';

class TituloPagina extends StatelessWidget {
  final String titulo;
  final bool? voltar;

  const TituloPagina({
    Key? key,
    required this.titulo,
    this.voltar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        voltar ?? false
            ? IconButton(
                icon: Icon(
                  AppIcons.voltar,
                  color: AppColors.preto,
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                visualDensity: VisualDensity.compact,
                onPressed: () => context.router.pop(),
              )
            : Container(),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.preto
          ),
        ),
      ],
    );
  }
}
