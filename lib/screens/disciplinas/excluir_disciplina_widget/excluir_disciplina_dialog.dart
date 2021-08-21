import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

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
              RepositoryDisciplina repositoryDisciplina =
                  RepositoryDisciplina();
              repositoryDisciplina.remover(disciplina.id);
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
  return true;
}
