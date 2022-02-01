import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';
import 'package:revisao_estudos/ui/widgets/lista_card_item_acoes/card_item_acoes/botoes_acoes/botoes_acoes.dart';

class CardItemAcoes<T extends EntityCommon> extends StatefulWidget {
  final T item;
  final CurrentIdCallback currentIdCallback;
  final EdgeInsetsGeometry? padding;
  final AcoesItemCallback? onPressedEditar;
  final AcoesItemCallback? onPressedExcluir;

  const CardItemAcoes({
    Key? key,
    required this.item,
    required this.currentIdCallback,
    this.padding,
    this.onPressedEditar,
    this.onPressedExcluir,
  }) : super(key: key);

  @override
  CardItemAcoesState<T> createState() => CardItemAcoesState<T>();
}

class CardItemAcoesState<T extends EntityCommon> extends State<CardItemAcoes> with AutomaticKeepAliveClientMixin {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    // Necessário para o AutomaticKeepAliveClientMixin.
    super.build(context);

    return Padding(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: GestureDetector(
        onTap: () => widget.currentIdCallback(widget.item.id),
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
                    widget.item.toString(),
                    style: TextStyle(
                      color: AppColors.preto,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              BotoesAcoes<T>(
                item: widget.item as T,
                showButton: _showButton,
                onPressedEditar: widget.onPressedEditar,
                onPressedExcluir: widget.onPressedExcluir,
              ),
            ],
          ),
        ),
      ),
    );
  }

  verficarEstadoBotoes() {
    if (widget.item.id == (widget.currentIdCallback(null) ?? -1)) {
      // Ativando os botões
      setState(() {
        _showButton = !_showButton;
      });
    } else {
      // Desativando os botões
      setState(() {
        _showButton = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
