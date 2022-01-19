import 'package:flutter/material.dart';

class DialogoConfirmacao extends StatelessWidget {
  final String titulo;
  final String? textoBotaoConfirmar;
  final String? textoBotaoRecusar;

  const DialogoConfirmacao({
    Key? key,
    required this.titulo,
    this.textoBotaoConfirmar,
    this.textoBotaoRecusar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      actions: [
        new TextButton(
          child: new Text(textoBotaoRecusar ?? 'CANCELAR'),
          onPressed: () => Navigator.pop(context, false),
        ),
        // Spacer(),
        new TextButton(
          child: new Text(textoBotaoConfirmar ?? 'CONFIRMAR'),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
