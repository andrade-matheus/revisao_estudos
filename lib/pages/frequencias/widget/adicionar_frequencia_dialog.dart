import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';

adicionarFrequenciaDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text('Adicionar Frequencia'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Nome da frequencia"),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Obrigatório.';
                  }
                  return null;
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('ADICIONAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Frequencia novaFrequencia =
                        new Frequencia(0, _textFieldController.text);
                    setState(() {
                      FrequenciaController.criarFrequencia(novaFrequencia);
                    });
                    Navigator.pop(context, true);
                    _textFieldController.clear();
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
  return true;
}
