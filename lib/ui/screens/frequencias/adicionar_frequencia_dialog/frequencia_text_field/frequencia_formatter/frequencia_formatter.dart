import 'dart:math';

import 'package:flutter/services.dart';

class FrequenciaFormatter extends TextInputFormatter {
  final String _separator = ' - ';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _textManipulation(
      oldValue,
      newValue,
      textInputFormatter: FilteringTextInputFormatter.digitsOnly,
      formatPattern: (filteredString) {
        int offset = 0;
        StringBuffer buffer = StringBuffer();

        for (int i = min(2, filteredString.length);
            i <= filteredString.length;
            i += min(2, max(1, filteredString.length - i))) {
          buffer.write(filteredString.substring(offset, i));
          if (i < filteredString.length) {
            buffer.write(_separator);
          }

          offset = i;
        }

        return buffer.toString();
      },
    );
  }

  TextEditingValue _textManipulation(
    TextEditingValue oldValue,
    TextEditingValue newValue, {
    TextInputFormatter? textInputFormatter,
    String formatPattern(String filteredString)?,
  }) {
    final originalUserInput = newValue.text;

    // Remover caracteres inválidos
    newValue = textInputFormatter != null
        ? textInputFormatter.formatEditUpdate(oldValue, newValue)
        : newValue;

    // Seleção atual
    int selectionIndex = newValue.selection.end;

    // Formata a string original
    final newText =
        formatPattern != null ? formatPattern(newValue.text) : newValue.text;

    if (newText == newValue.text) {
      return newValue;
    }

    // Contagem de novos caracteres inseridos na string
    int insertCount = 0;

    // Contagem de caracteres na string original
    int inputCount = 0;

    bool _isUserInput(String s) {
      if (textInputFormatter == null) return originalUserInput.contains(s);
      return newValue.text.contains(s);
    }

    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty,
    );
  }
}
