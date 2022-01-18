import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_fontes.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/revisao_tile/legenda_atraso/legenda_atraso.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/revisao_tile/legenda_frequencia/legenda_frequencia.dart';

class RevisaoTile extends StatefulWidget {
  final Revisao revisao;
  final bool last;
  final bool first;

  const RevisaoTile(
      {Key? key,
      required this.revisao,
      required this.last,
      required this.first})
      : super(key: key);

  @override
  _RevisaoTileState createState() => _RevisaoTileState();
}

class _RevisaoTileState extends State<RevisaoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          widget.first ? EdgeInsets.zero : EdgeInsets.fromLTRB(0, 5.0, 0, 0),
      decoration: BoxDecoration(
        border: !widget.last
            ? Border(
                bottom: BorderSide(
                  color: AppColors.laranjaBordaCard,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.revisao.nome,
                  style: TextStyle(
                    color: AppColors.preto,
                    fontSize: 16,
                    fontFamily: AppFontes.robotoLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3.0, 5.0, 0),
                      child: LegendaFrequencia(revisao: widget.revisao),
                    ),
                    LegendaAtraso(revisao: widget.revisao),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.check_outlined),
            onPressed: () async {
              await realizarRevisaoDialog(context);
              context.read<DataSelecionada>().updateState();
            },
          ),
        ],
      ),
    );
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
