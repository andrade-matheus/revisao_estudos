import 'package:flutter/material.dart';

Future<DateTime> escolherDataDialog(
  BuildContext context,
  DateTime dataSelecionada,
) async {
  DateTime? dataEscolhida = await showDatePicker(
    locale: const Locale("pt"),
    context: context,
    initialDate: dataSelecionada,
    firstDate: new DateTime(1970, 8),
    lastDate: new DateTime(2101),
  );
  return dataEscolhida ?? dataSelecionada;
}
