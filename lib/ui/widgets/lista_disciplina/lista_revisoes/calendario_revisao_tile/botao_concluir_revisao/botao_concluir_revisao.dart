import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';

class BotaoConcluirRevisao extends StatefulWidget {
  final Revisao revisao;
  final bool showButton;

  const BotaoConcluirRevisao({
    Key? key,
    required this.revisao,
    required this.showButton,
  }) : super(key: key);

  @override
  _BotaoConcluirRevisaoState createState() => _BotaoConcluirRevisaoState();
}

class _BotaoConcluirRevisaoState extends State<BotaoConcluirRevisao>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
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
      child: IconButton(
        icon: Icon(AppIcons.concluirRevisao),
        onPressed: widget.showButton
            ? () async {
                bool resultado = await realizarRevisaoDialog(context);
                if (resultado) {
                  widget.revisao.realizarRevisao();
                  context.read<DataSelecionada>().updateState();
                }
              }
            : null,
      ),
    );
  }

  Future<bool> realizarRevisaoDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return DialogoConfirmacao(
              titulo: 'Concluir revisão?',
              textoBotaoConfirmar: 'CONCLUIR',
            );
          },
        ) ??
        false;
  }
}
