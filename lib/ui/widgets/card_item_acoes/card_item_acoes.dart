import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';

class CardItemAcoes extends StatefulWidget {
  final String titulo;
  final VoidCallback? onPressedExcluir;
  final VoidCallback? onPressedEditar;
  final EdgeInsetsGeometry? padding;

  const CardItemAcoes({
    Key? key,
    required this.titulo,
    this.onPressedExcluir,
    this.onPressedEditar,
    this.padding,
  }) : super(key: key);

  @override
  _CardItemAcoesState createState() => _CardItemAcoesState();
}

class _CardItemAcoesState extends State<CardItemAcoes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        decoration: ShapeDecoration(
          shadows: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
          color: AppColors.branco,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.laranjaBordaCard,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  widget.titulo,
                  style: TextStyle(
                    color: AppColors.preto,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            (widget.onPressedEditar != null)
                ? IconButton(
                    onPressed: () => widget.onPressedEditar,
                    icon: Icon(AppIcons.editar),
                  )
                : Container(),
            (widget.onPressedExcluir != null)
                ? IconButton(
                    onPressed: widget.onPressedExcluir,
                    icon: Icon(AppIcons.exlucir),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
