import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_disciplina.dart';
import 'package:revisao_estudos/ui/widgets/revisai_floating_action_button/revisai_floating_action_button.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class RevisoesPage extends StatefulWidget {
  @override
  State<RevisoesPage> createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  @override
  Widget build(BuildContext context) {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

    return Scaffold(
      floatingActionButton: RevisaiFloatingActionButton(
        onPressed: () => context.router.push(const AdicionarRevisaoRoute()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 0, 20),
            child: TituloPagina(titulo: 'Todas revisões'),
          ),
          ListaDisciplina(
            futureDisciplina: repositoryDisciplina.obterTodasInculindoRevisoes(),
          ),
        ],
      ),
    );
  }
}
