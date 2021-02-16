import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/controllers/revisao_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/revisoes/adicionarRevisao/adicinar_revisao_page.dart';
import 'package:revisao_estudos/pages/revisoes/detalhesRevisao/detalhes_revisao_page.dart';
import 'package:revisao_estudos/pages/revisoes/exculirRevisao/excluir_revisao_dialog.dart';

class RevisoesPage extends StatefulWidget {
  @override
  _RevisoesPageState createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  Color corPrimaria = Colors.blue;
  Revisao novaRevisao;
  Future<List<Revisao>> futureRevisoes;
  List<Revisao> todasRevisoes = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CalendarioPage()));
        return true;
      },
      child: PlanoDeFundo(
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
                if(value){
                  setState(() {});
                }
              });
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: FutureBuilder(
            future: DisciplinaController.obterTodasDisciplinas(),
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
                                future: RevisaoController
                                    .obterTodasRevisoesPorDisciplina(
                                        disciplina),
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
                                                    DetalhesRevisaoPage(
                                                        revisao),
                                              ),
                                            );
                                          },
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete_outline),
                                            onPressed: () async {
                                              bool resultado = await excluirRevisaoDialog(context, revisao);
                                              if(resultado) {
                                                setState(() {});
                                              }
                                            }
                                          ),
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
      ),
    );
  }
}
