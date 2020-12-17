import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/models/provider/lista_revisoes_model.dart';

class RevisaoTile extends StatefulWidget {
  final Revisao revisao;

  const RevisaoTile({Key key, this.revisao}) : super(key: key);

  @override
  _RevisaoTileState createState() => _RevisaoTileState();
}

class _RevisaoTileState extends State<RevisaoTile> {
  @override
  Widget build(BuildContext context) {
    var listaRevisoesState = Provider.of<ListaRevisoesModel>(context);

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(30, 0, 50, 0),
      title: Text(widget.revisao.nome),
      leading: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
      ),
      trailing: IconButton(
        icon: Icon(Icons.check_outlined),
        onPressed: () async {
          bool resultado = await RevisaoController.realizarRevisao(widget.revisao);
          if (resultado){
            listaRevisoesState.updateState();
          }
        },
      ),
    );
  }
}
