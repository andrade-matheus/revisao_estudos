import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';

class RevisaiFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RevisaiFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.laranjaFloatingActionButton,
      child: Icon(
        AppIcons.adicionarFloatingActionButton,
        color: AppColors.branco,
        size: 20,
      ),
    );
  }
}
