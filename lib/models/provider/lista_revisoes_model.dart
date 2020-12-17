
import 'package:flutter/material.dart';

class ListaRevisoesModel extends ChangeNotifier{

  DateTime _dataSelecionada = DateTime.now();

  DateTime get dataSelecionada => _dataSelecionada;

  set dataSelecionada(DateTime novaData){
    _dataSelecionada = novaData;
    notifyListeners();
  }

  updateState(){
    notifyListeners();
  }
}