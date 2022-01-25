import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

excluirDisciplinaDialog(BuildContext context, Disciplina disciplina) async {
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
  bool utilizada = await repositoryDisciplina.utilizado(disciplina.id);

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Deseja mesmo excluir essa disciplina?"),
        content: utilizada
            ? Text('A disciplina possui revisões, se optar por exclui-la, todas as revisões vinculadas támbem serão excluídas.')
            : Text('A disciplina não possui nenhuma revisão vinculada a ela.'),
        actions: [
          new TextButton(
            child: new Text('CANCELAR'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new TextButton(
            child: new Text('EXCLUIR'),
            onPressed: () async {
              RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
              bool resultado = await repositoryDisciplina.remover(disciplina.id, force: true);
              Navigator.pop(context, resultado);
            },
          )
        ],
      );
    },
  );
  return true;
}
