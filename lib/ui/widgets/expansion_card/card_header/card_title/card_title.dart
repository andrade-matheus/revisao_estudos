import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class CardTitle extends StatelessWidget {
  final String? title;
  final TextStyle? style;

  const CardTitle({
    Key? key,
    this.title,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: style ??
          TextStyle(
            color: AppColors.preto,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
    );
  }
}
