import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';

class BotaoConcluirRevisao extends StatefulWidget {
  final Revisao revisao;

  const BotaoConcluirRevisao({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  _BotaoConcluirRevisaoState createState() => _BotaoConcluirRevisaoState();
}

class _BotaoConcluirRevisaoState extends State<BotaoConcluirRevisao> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.check_outlined),
      onPressed: () async {
        bool resultado = await realizarRevisaoDialog(context);
        if(resultado){
          widget.revisao.realizarRevisao();
          context.read<DataSelecionada>().updateState();
        }
      },
    );
  }

  Future<bool> realizarRevisaoDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return DialogoConfirmacao(
          titulo: 'Concluir revisão?',
          textoBotaoConfirmar: 'CONCLUIR',
          textoBotaoRecusar: 'CANCELAR',
        );
      },
    ) ?? false;
  }
}
