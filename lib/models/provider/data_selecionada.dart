import 'package:flutter/material.dart';

class DataSelecionada with ChangeNotifier {
  DateTime _dataSelecionada = DateTime.now().add(Duration(days: 30));

  DateTime get dataSelecionada => _dataSelecionada;

  defineData(DateTime novaData) {
    _dataSelecionada = novaData;
    notifyListeners();
  }

  reduzirUmDia() {
    _dataSelecionada = _dataSelecionada.subtract(Duration(days: 1));
    notifyListeners();
  }

  aumentarUmDia() {
    _dataSelecionada = _dataSelecionada.add(Duration(days: 1));
    notifyListeners();
  }

  updateState() {
    notifyListeners();
  }
}
