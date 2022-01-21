import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/routes/router.gr.dart';

class RevisaoTileRevisoes extends StatelessWidget {
  final Revisao revisao;

  const RevisaoTileRevisoes({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.router.push(DetalhesRevisaoRoute(revisao: revisao)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.laranjaBordaCard,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                child: Text(
                  revisao.nome,
                  style: TextStyle(
                    color: AppColors.preto,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
