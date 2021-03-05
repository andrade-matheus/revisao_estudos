import 'package:flutter/material.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Configurações",
      child: Column(),
    );
  }
}
