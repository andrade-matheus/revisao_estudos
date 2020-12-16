
import 'package:flutter/material.dart';

class SeletorDataModel extends ChangeNotifier{

  DateTime _dataSelecionada = DateTime.now();

  DateTime get dataSelecionada => _dataSelecionada;

  set dataSelecionada(DateTime novaData){
    _dataSelecionada = novaData;
    notifyListeners();
  }
}