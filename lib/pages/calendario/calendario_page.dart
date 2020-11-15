import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/database/repository_service_revisao.dart';
import 'package:revisao_estudos/models/disciplina.dart';
import 'package:revisao_estudos/models/revisao.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime dataSelecionada = DateTime.now();
  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calendário"),
        ),
        drawer: homeDrawer(context),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                dataSelecionada =
                                    dataSelecionada.subtract(Duration(days: 1));
                              });
                            },
                            child: Icon(Icons.arrow_back_outlined)),
                        ElevatedButton(
                            onPressed: () => _escolherDataDialog(context),
                            child:
                            Text(dataSelecionaToString(dataSelecionada))),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                dataSelecionada =
                                    dataSelecionada.add(Duration(days: 1));
                              });
                            },
                            child: Icon(Icons.arrow_forward_outlined)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getAllDisciplinasFromRevisoes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: Text(
                          "Sem revisões por hoje.",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Disciplina disciplina = snapshot.data[index];
                          return Column(
                            children: [
                              ExpansionTile(
                                initiallyExpanded: true,
                                title: Text(disciplina.nome),
                                children: [
                                  FutureBuilder(
                                    future: _getRevisoesByDisciplinaAndDate(
                                        disciplina),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            Revisao revisao =
                                            snapshot.data[index];
                                            return ListTile(
                                              contentPadding: EdgeInsets
                                                  .fromLTRB(30, 0, 50, 0),
                                              title: Text(revisao.nome),
                                              leading: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 15,
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(
                                                    Icons.check_outlined),
                                                onPressed: () {
                                                  setState(() {
                                                    confirmarRevisao(revisao);
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return Column();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    return Column();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String dataSelecionaToString(DateTime data) {
    return DateFormat.MMMMEEEEd('pt_BR').format(data);
  }

  _escolherDataDialog(BuildContext context) async {
    final DateTime dataEscolhida = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(1970, 8),
        lastDate: new DateTime(2101));
    setState(() {
      dataSelecionada = dataEscolhida ?? dataSelecionada;
    });
  }

  _getAllDisciplinasFromRevisoes() async {
    List<Revisao> revisoes = await RepositoryServiceRevisao.getRevisoesByDate(
        dataSelecionada);
    List<Disciplina> disciplinas = List();


    for (final node in revisoes) {
      Disciplina disciplina = Disciplina(0, node.disciplina, false);
      if(!disciplinas.contains(disciplina)){
        disciplinas.add(disciplina);
      }
    }

    return disciplinas;
  }

  _getRevisoesByDisciplinaAndDate(Disciplina disciplina) async {
    return await RepositoryServiceRevisao.getRevisoesByDisciplinaAndDate(
        disciplina, dataSelecionada);
  }

  confirmarRevisao(Revisao revisao) async {
    List<String> valoresFrequencia = revisao.frequencia.split('-');
    print("Tamanho frequencia: " + valoresFrequencia.length.toString());
    revisao.vezesRevisadas += 1;
    int vezesRevisadas = revisao.vezesRevisadas;

    if (vezesRevisadas >= valoresFrequencia.length) {
      vezesRevisadas = valoresFrequencia.length - 1;
    }

    int diasProxRevisao = int.parse(valoresFrequencia[vezesRevisadas]);
    revisao.proxRevisao = DateTime.now().add(Duration(days: diasProxRevisao));

    await RepositoryServiceRevisao.updateRevisao(revisao);
  }
}
