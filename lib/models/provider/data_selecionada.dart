import 'package:flutter/material.dart';

class DataSelecionada extends ChangeNotifier {
  DateTime _dataSelecionada = DateTime.now();

  DateTime get dataSelecionada => _dataSelecionada;

  defineData(DateTime novaData) {
    _dataSelecionada = novaData;
    notifyListeners();
  }

  reduzirUmDia() {
    _dataSelecionada.subtract(Duration(days: 1));
    notifyListeners();
  }

  aumentarUmDia() {
    _dataSelecionada.add(Duration(days: 1));
    notifyListeners();
  }

  updateState() {
    notifyListeners();
  }
}
