import 'package:flutter/material.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class SemRevisoes extends StatelessWidget {
  final DateTime? data;

  const SemRevisoes({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String texto = '';

    if (data != null) {
      int isToday = DateHelper.isToday(data!);
      if (isToday < 0) {
        texto = "Não houve revisões realizadas neste dia.";
      } else if (isToday == 0){
        texto = "Sem revisões por hoje.";
      } else if(isToday > 0){
        texto = "Sem revisões agendadas.";
      }
    } else {
      texto = 'Não possui revisões cadastradas';
    }

    return Center(
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
