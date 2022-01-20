import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/revisao_tile_calendario/legenda_revisao/legenda_atraso/legenda_atraso.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/revisao_tile_calendario/legenda_revisao/legenda_frequencia/legenda_frequencia.dart';

class LegendaRevisao extends StatelessWidget {
  final Revisao revisao;

  const LegendaRevisao({Key? key, required this.revisao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3.0, 0, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 2.0, 0),
            child: LegendaFrequencia(revisao: revisao),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 0, 0, 0),
            child: LegendaAtraso(revisao: revisao),
          ),
        ],
      ),
    );
  }
}
