import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';

class LogTile extends StatelessWidget {
  final Revisao revisao;

  const LogTile({Key key, this.revisao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(30, 0, 50, 0),
      title: Text(revisao.nome),
      leading: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
      ),
    );
  }
}
