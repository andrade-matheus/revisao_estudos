import 'package:flutter/material.dart';

Future<bool> confirmacaoRestaurarBackup(BuildContext context) async {
  bool resultado = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Tem certeza que deseja restaurar um backup?"),
        content: Text("Todos os dados não salvos serão apagados!"),
        actions: [
          new TextButton(
            child: new Text('CANCELAR'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          // Spacer(),
          new TextButton(
            child: new Text('CONFIRMAR'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );
  return resultado;
}
