import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/frequencias/adicionar_frequencia_dialog/frequencia_text_field/frequencia_formatter/frequencia_formatter.dart';

class FrequenciaTextField extends StatelessWidget {
  final TextEditingController controller;

  const FrequenciaTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FrequenciaFormatter(),
      ],
      decoration: InputDecoration(
        hintText: "Exemplo: 00 - 05 - 15 - 30",
      ),
      validator: (text) {
        String newText = text?.replaceAll(' ', '') ?? '';
        List<String> frequencias = newText.split('-');
        RegExp formatoFrequencia = RegExp(r'^(((\d{2,}-)+)((0[1-9])|([1-9][0-9])))$');
        if ((text == null || text.isEmpty)) {
          return 'Campo obrigatório.';
        } else if (text == '0' || text == '00') {
          return 'A frequência não pode ser apenas "00".';
        } else if (frequencias.last == '00') {
          return 'A frequência não pode terminar com "00".';
        } else if (!formatoFrequencia.hasMatch(newText)) {
          return 'Padrão de frequência inválida.';
        }
        return null;
      },
    );
  }
}
