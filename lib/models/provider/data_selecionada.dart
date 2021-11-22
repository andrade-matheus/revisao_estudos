import 'package:flutter/material.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class DataSelecionada with ChangeNotifier {
  DateTime _dataSelecionada = DateHelper.hoje();

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
