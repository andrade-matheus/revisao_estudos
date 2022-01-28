import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

class ExcluirDisciplinaDialog extends StatelessWidget {
  final Disciplina disciplina;
  final bool utilizada;

  const ExcluirDisciplinaDialog({
    Key? key,
    required this.disciplina,
    required this.utilizada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
