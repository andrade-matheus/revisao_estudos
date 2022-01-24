import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class BotaoRevisao extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final MaterialStateProperty<Color> backgroudColor;
  final EdgeInsetsGeometry? padding;

  const BotaoRevisao({
    Key? key,
    required this.texto,
    required this.onPressed,
    required this.backgroudColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: backgroudColor,
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            texto,
            style: TextStyle(
              color: AppColors.branco,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
