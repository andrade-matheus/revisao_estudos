import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';

//TODO receber os parametro certo para funcionar
adicionarDisciplinaDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool updateState = false;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Adicionar Disciplina'),
        content: Form(
            key: _formKey,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Nome da disciplina"),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Obrigatório.';
                }
                return null;
              },
            )),
        actions: <Widget>[
          new TextButton(
            child: new Text('CANCELAR'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // Spacer(),
          new TextButton(
            child: new Text('ADICIONAR'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                updateState = true;
                Disciplina novaDisciplina =
                    Disciplina(id: 0, nome: _textFieldController.text);
                RepositoryDisciplina repositoryDisciplina =
                    RepositoryDisciplina();
                repositoryDisciplina.insert(novaDisciplina);
                Navigator.pop(context);
                _textFieldController.clear();
              }
            },
          )
        ],
      );
    },
  );
  return updateState;
}
