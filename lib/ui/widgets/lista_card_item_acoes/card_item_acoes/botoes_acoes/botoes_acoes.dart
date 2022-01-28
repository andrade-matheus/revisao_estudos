import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';
import 'package:revisao_estudos/ui/widgets/lista_card_item_acoes/card_item_acoes/botoes_acoes/icone_botao_acao/icone_botao_acao.dart';

class BotoesAcoes<T extends EntityCommon> extends StatefulWidget {
  final T item;
  final bool showButton;
  final AcoesItemCallback? onPressedEditar;
  final AcoesItemCallback? onPressedExcluir;

  const BotoesAcoes({
    Key? key,
    required this.item,
    required this.showButton,
    this.onPressedExcluir,
    this.onPressedEditar,
  }) : super(key: key);

  @override
  _BotoesAcoesState<T> createState() => _BotoesAcoesState<T>();
}

class _BotoesAcoesState<T extends EntityCommon> extends State<BotoesAcoes>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (widget.showButton) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showButton) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return FadeTransition(
      opacity: _animation,
      child: Row(
        children: [
          IconeBotaoAcao<T>(
            item: widget.item as T,
            icon: AppIcons.editar,
            enable: widget.showButton,
            onPressed: widget.onPressedEditar,
          ),
          IconeBotaoAcao<T>(
            item: widget.item as T,
            icon: AppIcons.exlucir,
            enable: widget.showButton,
            onPressed: widget.onPressedExcluir,
          ),
        ],
      ),
    );
  }
}
