import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';

excluirFrequenciaDialog(BuildContext context, Frequencia frequencia) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa frequencia?"),
            actions: [
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('EXCLUIR'),
                onPressed: () {
                  setState(() {
                    FrequenciaController.deletarFrequencia(frequencia);
                  });
                  Navigator.pop(context);
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