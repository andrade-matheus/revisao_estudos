import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';

class RevisaoTileRevisoes extends StatelessWidget {
  final Revisao revisao;

  const RevisaoTileRevisoes({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(revisao.nome);
  }
}
