import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';

class RevisaoTile extends StatefulWidget {
  final Revisao revisao;

  const RevisaoTile({Key key, this.revisao}) : super(key: key);

  @override
  _RevisaoTileState createState() => _RevisaoTileState();
}

class _RevisaoTileState extends State<RevisaoTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(30, 0, 50, 0),
      title: Text(widget.revisao.nome),
      leading: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
      ),
      trailing: IconButton(
        icon: Icon(Icons.check_outlined),
        onPressed: () {
          setState(() {
            RevisaoController.realizarRevisao(widget.revisao);
          });
        },
      ),
    );
  }
}
