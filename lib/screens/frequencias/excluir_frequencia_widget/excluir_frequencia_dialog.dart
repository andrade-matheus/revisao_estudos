import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';

excluirFrequenciaDialog(BuildContext context, Frequencia frequencia) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Deseja mesmo excluir essa frequencia?"),
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
              RepositoryFrequencia repositoryFrequencia =
                  RepositoryFrequencia();
              repositoryFrequencia.delete(frequencia.id);
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
  return true;
}
