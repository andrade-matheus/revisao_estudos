import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';

class MostraFrequencia extends StatelessWidget {
  final Frequencia frequencia;
  final EdgeInsetsGeometry? padding;

  const MostraFrequencia({
    Key? key,
    required this.frequencia,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> frequenciaSeparada = frequencia.frequencia.split('-');

    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _criarFrequencias(frequenciaSeparada),
      ),
    );
  }

  List<Widget> _criarFrequencias(List<String> frequencias) {
    List<Widget> resultado = [];

    for (var i = 0; i < frequencias.length; i++) {
      String freq = frequencias[i];

      resultado.add(
        Container(
          margin: (i == 0)
              ? const EdgeInsets.fromLTRB(0, 0, 5, 0)
              : const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.laranjaBordaCard,
              ),
            ),
          ),
          child: Text(
            freq,
            style: TextStyle(
              color: AppColors.preto,
              fontWeight: FontWeight.w300,
              fontSize: 24,
            ),
          ),
        ),
      );

      if (i != frequencias.length - 1) {
        resultado.add(
          Text(
            '-',
            style: TextStyle(
              color: AppColors.preto,
              fontWeight: FontWeight.w300,
              fontSize: 24,
            ),
          ),
        );
      }
    }

    return resultado;
  }
}
