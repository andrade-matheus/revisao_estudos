import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/adicionar_disciplina_widget/adicionar_disciplina_dialog.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/excluir_disciplina_widget/excluir_disciplina_dialog.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';
import 'package:revisao_estudos/ui/widgets/lista_card_item_acoes/lista_card_item_acoes.dart';
import 'package:revisao_estudos/ui/widgets/revisai_floating_action_button/revisai_floating_action_button.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class DisciplinasPage extends StatefulWidget {
  @override
  _DisciplinasPageState createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: RevisaiFloatingActionButton(
        onPressed: () => adicionarDisciplinaDialog(context),
      ),
      body: Column(
        children: [
          TituloPagina(
            titulo: 'Disciplinas',
            padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
          ),
          FutureBuilder(
            future: repositoryDisciplina.obterTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Disciplina> disciplinas =
                      snapshot.data as List<Disciplina>;
                  return Expanded(
                    child: ListaCardItemAcoes<Disciplina>(
                      itens: disciplinas,
                      // onPressedEditar: (teste){},
                      onPressedExcluir: (disciplina) async {
                        final result = await excluirDisciplinaDialog(
                            context, disciplina as Disciplina);
                        if (result) {
                          setState(() {});
                        }
                      },
                    ),
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
}
