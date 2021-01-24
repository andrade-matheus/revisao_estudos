import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

excluirRevisaoDialog(BuildContext context, Revisao revisao) async{
  bool resultado = false;

  await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState){
            return AlertDialog(
              title: Text("Deseja mesmo excluir essa revisão?"),
              actions: [
                new FlatButton(
                  child: new Text('CANCELAR'),
                  onPressed: () {
                    Navigator.pop(context);
                    resultado = false;
                  },
                ),
                // Spacer(),
                new FlatButton(
                  child: new Text('EXCLUIR'),
                  onPressed: () {
                    setState(() {
                      RevisaoController.deletarRevisao(revisao);
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