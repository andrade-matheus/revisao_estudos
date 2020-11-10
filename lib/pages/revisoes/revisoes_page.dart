import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/database/repository_service_disciplina.dart';
import 'package:revisao_estudos/database/repository_service_revisao.dart';
import 'package:revisao_estudos/models/disciplina.dart';
import 'package:revisao_estudos/models/revisao.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';
import 'package:revisao_estudos/pages/revisoes/adicinar_revisao_page.dart';

class RevisoesPage extends StatefulWidget {
  @override
  _RevisoesPageState createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  // final _formKey = GlobalKey<FormState>();
  // TextEditingController _textFieldController = TextEditingController();
  Color corPrimaria = Colors.blue;
  Revisao novaRevisao;
  Future<List<Revisao>> futureRevisoes;
  List<Revisao> todasRevisoes = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CalendarioPage())
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Revisões"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdicionarRevisaoPage()
                      ));

                  if(result){
                    setState(() {});
                  }
                }),
          ],
        ),
        drawer: homeDrawer(context),
        body:  Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: FutureBuilder(
            future: getDisciplina(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Disciplina disciplina = snapshot.data[index];
                    return Column(
                      children: [
                        Card(
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(disciplina.nome),
                            children: [
                              FutureBuilder(
                                future: getRevisaoByDisciplina(disciplina.nome),
                                builder: (context, snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    return ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        Revisao revisao = snapshot.data[index];
                                        return ListTile(
                                          contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                          title: Text(revisao.nome),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete_outline),
                                            onPressed: () => _excluirRevisaoDialog(context, revisao),
                                          ),
                                        );
                                      },
                                    );
                                  }else{
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
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ),
    );
  }

  _excluirRevisaoDialog(BuildContext context, Revisao revisao){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa revisão?"),
            actions: [
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('EXCLUIR'),
                onPressed: () {
                  setState(() {
                    deleteRevisao(revisao);
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  getDisciplina() async {
    List<Disciplina> todasDisciplinas = List();
    todasDisciplinas = await RepositoryServiceDisciplina.getAllDisciplinas();
    todasDisciplinas.sort((a,b) => a.nome.compareTo(b.nome));
    return todasDisciplinas;
  }

  getRevisaoByDisciplina(String disciplina) async {
    List<Revisao> todasRevisoesDisciplina = List();
    todasRevisoesDisciplina = await RepositoryServiceRevisao.getRevisaoByDisciplina(disciplina);
    todasRevisoesDisciplina.sort((a,b) => a.nome.compareTo(b.nome));
    return todasRevisoesDisciplina;
  }

  deleteRevisao(revisao) async{
    await RepositoryServiceRevisao.deleteRevisao(revisao);
  }

}
