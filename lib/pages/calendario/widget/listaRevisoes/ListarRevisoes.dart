import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/controllers/log_revisao_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/models/provider/lista_revisoes_model.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/listas/list_view_disciplinas.dart';
import 'package:revisao_estudos/pages/calendario/widget/listaRevisoes/widget/sem_revisoes/semRevisoes.dart';

class ListarRevisoes extends StatefulWidget {
  @override
  _ListarRevisoesState createState() => _ListarRevisoesState();
}

class _ListarRevisoesState extends State<ListarRevisoes> {
  bool _isLog = false;

  @override
  Widget build(BuildContext context) {
    List<Disciplina> disciplinas;
    List<Revisao> revisoes;

    return Consumer<ListaRevisoesModel>(
      builder: (context, listaRevisoesState, _) {
        DateTime data = listaRevisoesState.dataSelecionada;
        return FutureBuilder(
          future: _defineRevisoesPorData(data),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              revisoes = snapshot.data;
              disciplinas = DisciplinaController.obterTodasDisciplinasDeRevisoes(revisoes);
              if (revisoes.length == 0) {
                return SemRevisoes();
              }else{
                return ListaDeDisciplinas(
                disciplinas: disciplinas,
                revisoes: revisoes,
                isLog: _isLog,
                );
              }
            } else {
              return Column();
            }
          },
        );
      },
    );
  }

  Future<List<Revisao>> _defineRevisoesPorData(DateTime data) async {
    DateTime now = DateTime.now();
    DateTime hoje = DateTime(now.year, now.month, now.day);
    DateTime amanha = hoje.add(Duration(days: 1));
    List<Revisao> revisoes;
    if (data.isBefore(hoje)) {
      _isLog = true;
      revisoes = await LogRevisaoController.obterRevisoesDosLogsPorData(data);
    } else if (data.isBefore(amanha)) {
      _isLog = false;
      revisoes = await RevisaoController.obterTodasRevisoesParaHoje();
    } else {
      _isLog = true;
      revisoes = await RevisaoController.obterTodasRevisoesPorData(data);
    }
    return revisoes;
  }
}
