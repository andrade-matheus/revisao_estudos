import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/models/provider/lista_revisoes_model.dart';

class RevisaoTile extends StatefulWidget {
  final Revisao revisao;

  const RevisaoTile({Key key, this.revisao}) : super(key: key);

  @override
  _RevisaoTileState createState() => _RevisaoTileState();
}

class _RevisaoTileState extends State<RevisaoTile> {
  @override
  Widget build(BuildContext context) {
    var listaRevisoesState = Provider.of<ListaRevisoesModel>(context);

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(30, 0, 50, 0),
      visualDensity: VisualDensity.compact,
      title: Text(widget.revisao.nome),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: RichText(
          text: TextSpan(
            children: _criarLegendaFrequencias(widget.revisao),
          ),
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.check_outlined),
        onPressed: () async {
          bool resultado =
              await RevisaoController.realizarRevisao(widget.revisao);
          if (resultado) {
            listaRevisoesState.updateState();
          }
        },
      ),
    );
  }

  List<TextSpan> _criarLegendaFrequencias(Revisao revisao) {
    List<TextSpan> frequenciasWidgets = List();
    List<String> frequencias = revisao.frequencia.frequencia.split('-');
    int numeroFreq = frequencias.length;
    int vezesRevisadas = revisao.vezesRevisadas;
    int diasAtraso = _diasDeAtraso(revisao);
    bool atrasado = (diasAtraso > 0) ? true : false;

    TextStyle styleSelecinado;

    TextStyle styleNormal = TextStyle(
      color: Colors.black,
    );

    TextStyle styleAtrasado = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );

    TextStyle styleEmDia = TextStyle(
      color: Colors.indigo,
      fontWeight: FontWeight.bold,
    );

    int freqSelecionada = 0;
    if (vezesRevisadas < numeroFreq) {
      freqSelecionada = vezesRevisadas;
    } else {
      freqSelecionada = numeroFreq - 1;
    }

    for (int i = 0; i < numeroFreq; i++) {
      // Definindo qual o text style sera aplicado na frequencia
      if (i == freqSelecionada) {
        styleSelecinado = atrasado ? styleAtrasado : styleEmDia;
      } else {
        styleSelecinado = styleNormal;
      }

      TextSpan novaFreq = TextSpan(
        text: frequencias[i],
        style: styleSelecinado,
      );

      frequenciasWidgets.add(novaFreq);

      if (i != numeroFreq - 1) {
        frequenciasWidgets.add(
          TextSpan(
            text: ' - ',
            style: styleNormal,
          ),
        );
      }
    }

    if(atrasado){
      frequenciasWidgets.add(
        TextSpan(
          text: ' (Atrasado $diasAtraso dias)',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return frequenciasWidgets;
  }

  int _diasDeAtraso(Revisao revisao) {
    DateTime now = new DateTime.now();
    DateTime hoje = new DateTime(now.year, now.month, now.day);

    return hoje.difference(revisao.proxRevisao).inDays;
  }
}
