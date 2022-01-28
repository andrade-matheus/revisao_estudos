import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/disciplinas/adicionar_editar_disciplina_widget/adicionar_editar_disciplina_dialog.dart';
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
        onPressed: () => adicionarDisciplina(),
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
                  List<Disciplina> disciplinas = snapshot.data as List<Disciplina>;
                  return Expanded(
                    child: ListaCardItemAcoes<Disciplina>(
                      itens: disciplinas,
                      onPressedEditar: (disciplina) => editarDisciplina(disciplina as Disciplina),
                      onPressedExcluir: (disciplina) => excluirDisciplina(disciplina as Disciplina),
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

  adicionarDisciplina() async {
    var updateState = await showDialog(
      context: context,
      builder: (context) {
        return AdicionarEditarDisciplinaDialog(
          titulo: 'Nova disciplina',
          botaoConfirmar: 'ADICIONAR',
          onPressed: (nomeDisciplina) {
            RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
            repositoryDisciplina.adicionar(
              Disciplina(
                id: 0,
                nome: nomeDisciplina,
              ),
            );
          },
        );
      },
    );

    if (updateState ?? false) {
      setState(() {});
    }
  }

  editarDisciplina(Disciplina disciplina) async {
    var updateState = await showDialog(
      context: context,
      builder: (context) {
        return AdicionarEditarDisciplinaDialog(
          titulo: 'Renomear disciplina',
          botaoConfirmar: 'EDITAR',
          onPressed: (nomeDisciplina) {
            RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
            repositoryDisciplina.atualizar(
              Disciplina(
                id: disciplina.id,
                nome: nomeDisciplina,
              ),
            );
          },
        );
      },
    );

    if (updateState ?? false) {
      setState(() {});
    }
  }

  excluirDisciplina(Disciplina disciplina) async {
    RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
    bool utilizada = await repositoryDisciplina.utilizado(disciplina.id);

    var updateState = await showDialog(
      context: context,
      builder: (context) {
        return ExcluirDisciplinaDialog(
          disciplina: disciplina,
          utilizada: utilizada,
        );
      },
    );

    if (updateState ?? false) {
      setState(() {});
    }
  }
}
