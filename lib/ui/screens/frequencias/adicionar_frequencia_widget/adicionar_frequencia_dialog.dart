import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';

adicionarFrequenciaDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool updateState = false;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Adicionar Frequencia'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Exemplo: 0-5-15-30"),
            validator: (text) {
              List<String> frequencias = text?.split('-') ?? [];
              RegExp formatoFrequencia = RegExp(r'^([0-9]+[-])*([1-9][0-9]*)$');
              if (text == null || text.isEmpty) {
                return 'Campo obrigatório.';
              } else if (text == '0') {
                return 'A frequência não pode ser apenas "0".';
              } else if (frequencias.last == '0') {
                return 'A frequência não pode terminar com "0".';
              } else if (!formatoFrequencia.hasMatch(text)) {
                return 'A frequencia dada não está dentro do padrão correto.';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text('CANCELAR'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          // Spacer(),
          new TextButton(
            child: new Text('ADICIONAR'),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                updateState = true;
                Frequencia novaFrequencia = new Frequencia(
                  id: 0,
                  frequencia: _textFieldController.text,
                );
                RepositoryFrequencia repositoryFrequencia =
                    RepositoryFrequencia();
                repositoryFrequencia.adicionar(novaFrequencia);
                Navigator.pop(context, true);
                _textFieldController.clear();
              }
            },
          ),
        ],
      );
    },
  );
  return updateState;
}
