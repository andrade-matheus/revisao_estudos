import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_disciplina.dart';
import 'package:revisao_estudos/ui/widgets/revisai_floating_action_button/revisai_floating_action_button.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class RevisoesPage extends StatefulWidget {
  @override
  _RevisoesPageState createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  Color corPrimaria = Colors.blue;
  late Revisao novaRevisao;
  late Future<List<Revisao>> futureRevisoes;
  List<Revisao> todasRevisoes = [];

  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RevisaiFloatingActionButton(
        onPressed: () => context.router.push(const AdicionarRevisaoRoute()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
            child: TituloPagina(titulo: 'Todas revisões'),
          ),
          ListaDisciplina(
            futureDisciplina: repositoryDisciplina.obterTodasInculindoRevisoes(),
            isCalendario: false,
          ),
        ],
      ),
    );
  }
}
