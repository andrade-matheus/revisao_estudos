import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';

@deprecated
Future<bool> confirmacaoRestaurarBackup(BuildContext context) async {
  bool resultado = await showDialog(
        context: context,
        builder: (context) {
          return DialogoConfirmacao(
            titulo: 'Tem certeza que deseja restaurar um backup?',
            texto: 'Todos os dados não salvos serão apagados!',
          );
        },
      ) ??
      false;
  return resultado;
}
