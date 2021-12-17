import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class RevisaoTile extends StatefulWidget {
  final Revisao revisao;

  const RevisaoTile({Key key, this.revisao}) : super(key: key);

  @override
  _RevisaoTileState createState() => _RevisaoTileState();
}

class _RevisaoTileState extends State<RevisaoTile> {
  @override
  Widget build(BuildContext context) {
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
          await realizarRevisaoDialog(context);
          context.read<DataSelecionada>().updateState();
        },
      ),
    );
  }

  List<TextSpan> _criarLegendaFrequencias(Revisao revisao) {
    List<TextSpan> frequenciasWidgets = [];
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

    if (atrasado) {
      String legenda = ' (Atrasado $diasAtraso ';
      legenda += (diasAtraso > 1) ? "dias)" : "dia)";
      frequenciasWidgets.add(
        TextSpan(
          text: legenda,
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return frequenciasWidgets;
  }

  int _diasDeAtraso(Revisao revisao) {
    return DateHelper.hoje().difference(revisao.proxRevisao).inDays;
  }

  Future<bool> realizarRevisaoDialog(BuildContext context) async {
    bool resultado = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Concluir revisão?"),
          actions: [
            new TextButton(
              child: new Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Spacer(),
            new TextButton(
              child: new Text('CONCLUIR'),
              onPressed: () async {
                resultado = true;
                widget.revisao.realizarRevisao();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
    return resultado;
  }
}
