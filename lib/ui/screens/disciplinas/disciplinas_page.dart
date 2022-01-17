import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/excluir_disciplina_widget/excluir_disciplina_dialog.dart';

class DisciplinasPage extends StatefulWidget {
  @override
  _DisciplinasPageState createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  Color corPrimaria = Colors.blue;
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder(
        future: repositoryDisciplina.obterTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Disciplina disciplina = snapshot.data[index];
                return Card(
                  child: ListTile(
                    title: Text(disciplina.nome),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () async {
                        final result = await excluirDisciplinaDialog(
                            context, disciplina);
                        if (result) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}