import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';

excluirRevisaoDialog(BuildContext context, Revisao revisao) async {
  bool resultado = false;
  RepositoryRevisao repositoryRevisao = RepositoryRevisao();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa revisão?"),
            actions: [
              new TextButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context);
                  resultado = false;
                },
              ),
              // Spacer(),
              new TextButton(
                child: new Text('EXCLUIR'),
                onPressed: () {
                  setState(() {
                    repositoryRevisao.remover(revisao.id);
                  });
                  Navigator.pop(context);
                  resultado = true;
                },
              )
            ],
          );
        },
      );
    },
  );

  return resultado;
}
