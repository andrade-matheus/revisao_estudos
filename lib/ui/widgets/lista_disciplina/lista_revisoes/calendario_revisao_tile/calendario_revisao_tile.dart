import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/models/provider/botao_concluir_revisao.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/calendario_revisao_tile/botao_concluir_revisao/botao_concluir_revisao.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/calendario_revisao_tile/legenda_revisao/legenda_revisao.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/calendario_revisao_tile/titulo_revisao/titulo_revisao.dart';

class CalendarioRevisaoTile extends StatefulWidget {
  final Revisao revisao;
  final bool last;
  final bool first;

  const CalendarioRevisaoTile({
    Key? key,
    required this.revisao,
    required this.last,
    required this.first,
  }) : super(key: key);

  @override
  _CalendarioRevisaoTileState createState() => _CalendarioRevisaoTileState();
}

class _CalendarioRevisaoTileState extends State<CalendarioRevisaoTile> {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    int id = context.watch<BotaoConcluirRevisaoProvider>().revisaoId;
    _showButton = _showButton && widget.revisao.id == id;
    return GestureDetector(
      onTap: () async {
        if (widget.revisao.id == id && _showButton) {
          bool? update = await context.router.push(DetalhesRevisaoRoute(revisao: widget.revisao));
          if (update ?? false) {
            setState(() {});
          }
        } else {
          context
              .read<BotaoConcluirRevisaoProvider>()
              .trocarRevisao(widget.revisao.id);
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
