import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/screens/revisao/detalhes_revisao/detalhes_revisao_page.dart';
import 'package:revisao_estudos/ui/screens/revisao/exculir_revisao_widget/excluir_revisao_dialog.dart';

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
  RepositoryRevisao repositoryRevisao = RepositoryRevisao();

  //TODO: REFATORAR TUDO
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder(
        future: repositoryDisciplina.obterTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Disciplina> disciplinas = snapshot.data as List<Disciplina>;
              return ListView.builder(
                itemCount: disciplinas.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = disciplinas[index];
                  return Column(
                    children: [
                      Card(
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          title: Text(disciplina.nome),
                          children: [
                            FutureBuilder(
                              future: repositoryRevisao
                                  .obterPorDisciplina(disciplina),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    List<Revisao> revisoes =
                                        snapshot.data as List<Revisao>;
                                    return ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: revisoes.length,
                                      itemBuilder: (context, index) {
                                        Revisao revisao = revisoes[index];
                                        return ListTile(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(30, 0, 0, 0),
                                          title: Text(revisao.nome),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetalhesRevisaoPage(
                                                        revisao: revisao),
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
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
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
              return Container();
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
