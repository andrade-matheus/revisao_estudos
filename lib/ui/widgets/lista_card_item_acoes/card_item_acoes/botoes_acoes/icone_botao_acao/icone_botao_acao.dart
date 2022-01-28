import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';

class IconeBotaoAcao<T extends EntityCommon> extends StatelessWidget {
  final T item;
  final IconData icon;
  final bool enable;
  final AcoesItemCallback? onPressed;

  const IconeBotaoAcao({
    Key? key,
    required this.item,
    required this.icon,
    required this.enable,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: (onPressed != null) ? AppColors.preto : Colors.transparent,
      ),
      onPressed: (onPressed != null && enable) ? (() => onPressed!(item)) : null,
    );
  }
}
