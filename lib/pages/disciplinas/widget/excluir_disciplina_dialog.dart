import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';

excluirDisciplinaDialog(BuildContext context, Disciplina disciplina) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa disciplina?"),
            actions: [
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('EXCLUIR'),
                onPressed: () {
                  setState(() {
                    DisciplinaController.deletarDisciplina(disciplina);
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    },
  );
  return true;
}