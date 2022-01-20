import 'package:flutter/material.dart';

class BotaoConcluirRevisaoProvider with ChangeNotifier {
  int? _revisaoId = 0;

  int get revisaoId => _revisaoId ?? -1;

  trocarRevisao(int id) {
    _revisaoId = id;
    notifyListeners();
  }
}
