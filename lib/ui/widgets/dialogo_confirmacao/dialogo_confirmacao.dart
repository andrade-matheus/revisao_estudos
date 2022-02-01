import 'package:flutter/material.dart';

class DialogoConfirmacao extends StatelessWidget {
  final String titulo;
  final String? texto;
  final String? textoBotaoCancelar;
  final String? textoBotaoConfirmar;
  final bool mensagemUsuario;

  const DialogoConfirmacao({
    Key? key,
    required this.titulo,
    this.texto,
    this.textoBotaoConfirmar,
    this.textoBotaoCancelar,
    this.mensagemUsuario = false,
  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: (texto != null) ? Text(texto!) : null,
      actions: [
        !mensagemUsuario ?
        new TextButton(
          child: new Text(textoBotaoCancelar ?? 'CANCELAR'),
          onPressed: () => Navigator.pop(context, false),
        ) : Container(),
        // Spacer(),
        new TextButton(
          child: new Text(textoBotaoConfirmar ?? (mensagemUsuario ? 'OK' : 'CONFIRMAR')),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
