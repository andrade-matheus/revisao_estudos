import 'package:flutter/material.dart';

class ExcluirDialog extends StatelessWidget {
  final String entidade;
  final bool utilizada;
  final Function onPressed;

  const ExcluirDialog({
    Key? key,
    required this.entidade,
    required this.utilizada,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Deseja mesmo excluir essa $entidade?"),
      content: utilizada
          ? Text('A $entidade possui revisões, se optar por exclui-la, todas as revisões vinculadas támbem serão excluídas.')
          : Text('A $entidade não possui nenhuma revisão vinculada a ela.'),
      actions: [
        new TextButton(
          child: new Text('CANCELAR'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new TextButton(
          child: new Text('EXCLUIR'),
          onPressed: () => onPressed,
        )
      ],
    );
  }
}
