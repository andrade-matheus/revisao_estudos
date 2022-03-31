import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/ui/screens/frequencias/adicionar_frequencia_dialog/frequencia_text_field/frequencia_text_field.dart';

class AdicionarFequenciaDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text('Adicionar Frequência'),
      content: Form(
        key: _formKey,
        child: FrequenciaTextField(
          controller: _controller,
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
              Frequencia novaFrequencia = new Frequencia(
                id: 0,
                frequencia: _controller.text.replaceAll(' ', ''),
              );
              RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
              repositoryFrequencia.add(novaFrequencia);
              Navigator.pop(context, true);
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
