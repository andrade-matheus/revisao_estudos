import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';

//TODO receber os parametro certo para funcionar
adicionarDisciplinaDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
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
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('ADICIONAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Disciplina novaDisciplina =
                    new Disciplina(0, _textFieldController.text);
                    setState(() {
                      DisciplinaController.criarDisciplina(novaDisciplina);
                    });
                    Navigator.pop(context);
                    _textFieldController.clear();
                  }
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