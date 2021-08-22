import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/screens/revisao/adicionar_revisao/adicinar_revisao_page.dart';
import 'package:revisao_estudos/screens/revisao/detalhes_revisao/detalhes_revisao_page.dart';
import 'package:revisao_estudos/screens/revisao/exculir_revisao_widget/excluir_revisao_dialog.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/widgets/plano_de_fundo_widget/plano_de_fundo.dart';

class RevisoesPage extends StatefulWidget {
  @override
  _RevisoesPageState createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  Color corPrimaria = Colors.blue;
  Revisao novaRevisao;
  Future<List<Revisao>> futureRevisoes;
  List<Revisao> todasRevisoes = [];

  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
  RepositoryRevisao repositoryRevisao = RepositoryRevisao();

  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Revisões",
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdicionarRevisaoPage(),
              ),
            ).then((value) {
              if (value) {
                setState(() {});
              }
            });
          },
        ),
      ],
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: FutureBuilder(
          future: repositoryDisciplina.obterTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = snapshot.data[index];
                  return Column(
                    children: [
                      Card(
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          title: Text(disciplina.nome),
                          children: [
                            FutureBuilder(
                              future: repositoryRevisao
                                  .obterTodosPorDisciplina(disciplina),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      Revisao revisao = snapshot.data[index];
                                      return ListTile(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        title: Text(revisao.nome),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalhesRevisaoPage(revisao),
                                            ),
                                          );
                                        },
                                        trailing: IconButton(
                                            icon: Icon(Icons.delete_outline),
                                            onPressed: () async {
                                              bool resultado =
                                                  await excluirRevisaoDialog(
                                                      context, revisao);
                                              if (resultado) {
                                                setState(() {});
                                              }
                                            }),
                                      );
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
