import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_fontes.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';

class LegendaFrequencia extends StatelessWidget {
  final Revisao revisao;

  const LegendaFrequencia({Key? key, required this.revisao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
          child: Icon(
            AppIcons.frequencias,
            color: AppColors.laranjaLegendaFrequencia,
            size: 15,
          ),
        ),
        RichText(
          text: TextSpan(
            children: _criarLegendaFrequencias(revisao),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _criarLegendaFrequencias(Revisao revisao) {
    List<TextSpan> frequenciasWidgets = [];
    List<String> frequencias = revisao.frequencia?.frequencia.split('-') ?? [];
    int numeroFreq = frequencias.length;
    int vezesRevisadas = revisao.vezesRevisadas;

    TextStyle styleNormal = TextStyle(
        shadows: [
          Shadow(
            color: AppColors.preto,
            offset: Offset(0, -1),
          ),
        ],
        color: Colors.transparent,
        fontFamily: AppFontes.robotoThin,
        fontWeight: FontWeight.w300);

    TextStyle styleFreqAtual = TextStyle(
      shadows: [
        Shadow(color: AppColors.preto, offset: Offset(0, -1), blurRadius: 0),
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.preto,
      decorationThickness: 1,
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: AppFontes.robotoThin,
      fontWeight: FontWeight.w300,
    );

    int freqSelecionada =
        (vezesRevisadas > numeroFreq) ? numeroFreq - 1 : vezesRevisadas;

    var textIfen = TextSpan(
      text: ' - ',
      style: styleNormal,
    );

    for (int i = 0; i < numeroFreq; i++) {
      TextSpan novaFreq = TextSpan(
        text: frequencias[i],
        style: (i == freqSelecionada) ? styleFreqAtual : styleNormal,
      );
      frequenciasWidgets.add(novaFreq);

      if (i < numeroFreq - 1) {
        frequenciasWidgets.add(textIfen);
      }
    }
    return frequenciasWidgets;
  }
}
