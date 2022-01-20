import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/botao_concluir_revisao.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/revisao_tile_calendario/botao_concluir_revisao/botao_concluir_revisao.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/revisao_tile_calendario/legenda_revisao/legenda_revisao.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/revisao_tile_calendario/titulo_revisao/titulo_revisao.dart';

class RevisaoTileCalendario extends StatefulWidget {
  final Revisao revisao;
  final bool last;
  final bool first;

  const RevisaoTileCalendario(
      {Key? key,
      required this.revisao,
      required this.last,
      required this.first})
      : super(key: key);

  @override
  _RevisaoTileCalendarioState createState() => _RevisaoTileCalendarioState();
}

class _RevisaoTileCalendarioState extends State<RevisaoTileCalendario> {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    int id = context.watch<BotaoConcluirRevisaoProvider>().revisaoId;
    _showButton = _showButton && widget.revisao.id == id;
    return GestureDetector(
      onTap: () {
        if (widget.revisao.id == id && _showButton) {
          context.navigateTo(DetalhesRevisaoRoute(revisao: widget.revisao));
        } else {
          context.read<BotaoConcluirRevisaoProvider>().trocarRevisao(widget.revisao.id);
          setState(() {
            _showButton = !_showButton;
          });
        }
      },
      child: Container(
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
