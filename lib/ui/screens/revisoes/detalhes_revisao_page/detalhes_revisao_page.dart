import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/screens/revisoes/botao_revisao/botao_revisao.dart';
import 'package:revisao_estudos/ui/screens/revisoes/detalhes_revisao_page/detalhes_card_widget/detalhes_card.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class DetalhesRevisaoPage extends StatefulWidget {
  final Revisao revisao;

  const DetalhesRevisaoPage({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  _DetalhesRevisaoPageState createState() => _DetalhesRevisaoPageState();
}

class _DetalhesRevisaoPageState extends State<DetalhesRevisaoPage> {
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: TituloPagina(
              titulo: 'Detalhes da revisão',
              voltar: true,
            ),
          ),
          FutureBuilder(
            future:
                repositoryDisciplina.obterPorId(widget.revisao.disciplinaId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Disciplina? _disciplina = snapshot.data as Disciplina?;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetalhesCard(
                        title: "Disciplina",
                        text: _disciplina?.nome ?? '',
                      ),
                      DetalhesCard(
                        title: "Nome da revisão",
                        text: widget.revisao.nome,
                      ),
                      DetalhesCard(
                        title: "Frequência",
                        text: widget.revisao.frequencia.frequencia,
                      ),
                      DetalhesCard(
                        title: "Quantidade de revisões concluídas",
                        text: widget.revisao.vezesRevisadas.toString(),
                      ),
                      DetalhesCard(
                        title: "Data do cadastro",
                        text: DateFormat('dd / MM / yyyy')
                            .format(widget.revisao.dataCadastro),
                      ),
                      DetalhesCard(
                        title: "Data da próxima revisão",
                        text: DateFormat('dd / MM / yyyy')
                            .format(widget.revisao.proxRevisao),
                      ),
                      Row(
                        children: [
                          BotaoRevisao(
                            texto: 'Excluir revisão',
                            onPressed: _excluirRevisao,
                            backgroudColor: AppColors.botaoNovaRevisaoCancelar,
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              } else {
                return Carregando();
              }
            },
          ),
        ],
      ),
    );
  }

  _excluirRevisao() async {
    bool? resultado = await showDialog(
      context: context,
      builder: (context) {
        return DialogoConfirmacao(titulo: 'Excluir revisão?');
      },
    );

    if (resultado ?? false) {
      RepositoryRevisao repositoryRevisao = RepositoryRevisao();
      repositoryRevisao.remover(widget.revisao.id);
      context.router.pop(true);
    }
  }
}
