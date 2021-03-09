import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';

excluirDisciplinaDialog(BuildContext context, Disciplina disciplina) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Deseja mesmo excluir essa disciplina?"),
        actions: [
          new TextButton(
            child: new Text('CANCELAR'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new TextButton(
            child: new Text('EXCLUIR'),
            onPressed: () {
              DisciplinaController.deletarDisciplina(disciplina);
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
  return true;
}
