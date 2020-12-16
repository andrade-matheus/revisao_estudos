import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/tiles/revisao_tile.dart';

class ListaDeRevisoes extends StatelessWidget {
  final List<Revisao> revisoes;

  const ListaDeRevisoes({Key key, this.revisoes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: revisoes.length,
      itemBuilder: (context, index) {
        Revisao revisao = revisoes[index];
        return RevisaoTile(revisao: revisao);
      },
    );
  }
}
