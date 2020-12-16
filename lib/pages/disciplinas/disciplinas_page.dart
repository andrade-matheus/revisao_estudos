import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/disciplina_controller.dart';
import 'package:revisao_estudos/models/classes/disciplina.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/disciplinas/widget/adicionar_disciplina_dialog.dart';
import 'package:revisao_estudos/pages/disciplinas/widget/excluir_disciplina_dialog.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';

class DisciplinasPage extends StatefulWidget {
  @override
  _DisciplinasPageState createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CalendarioPage()));
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Disciplinas"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final result = await adicionarDisciplinaDialog(context);
                  if (result) {
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          drawer: homeDrawer(context),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: FutureBuilder(
              future: DisciplinaController.obterTodasDisciplinas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Disciplina disciplina = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(disciplina.nome),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () async {
                              final result = await excluirDisciplinaDialog(context, disciplina);
                              if (result) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          )),
    );
  }
}
