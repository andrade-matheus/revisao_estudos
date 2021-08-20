import 'package:flutter/material.dart';

mensagemResultadoBackUp(BuildContext context,String mensagem){
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(mensagem),
        children: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  );
}