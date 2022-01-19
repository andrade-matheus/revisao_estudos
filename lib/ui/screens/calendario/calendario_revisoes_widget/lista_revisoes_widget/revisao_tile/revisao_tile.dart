import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/revisao_tile/botao_concluir_revisao/botao_concluir_revisao.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/revisao_tile/legenda_revisao/legenda_revisao.dart';
import 'package:revisao_estudos/ui/screens/calendario/calendario_revisoes_widget/lista_revisoes_widget/revisao_tile/titulo_revisao/titulo_revisao.dart';

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
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showButton = !_showButton;
        });
      },
      child: Container(
        padding: widget.first
            ? EdgeInsets.zero
            : EdgeInsets.fromLTRB(0, 5.0, 0, 0),
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
                  TitutoRevisao(nomeRevisao: widget.revisao.nome),
                  LegendaRevisao(revisao: widget.revisao),
                ],
              ),
            ),
            BotaoConcluirRevisao(
              revisao: widget.revisao,
              showButton: _showButton,
            ),
          ],
        ),
      ),
    );
  }
}
