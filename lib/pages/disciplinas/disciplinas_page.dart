import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/database/repository_service_disciplina.dart';
import 'package:revisao_estudos/models/disciplina.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';

class DisciplinasPage extends StatefulWidget {
  @override
  _DisciplinasPageState createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Color corPrimaria = Colors.blue;

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
            title: Text("Disciplinas"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _adicionarDisciplinaDialog(context),
              ),
            ],
          ),
          drawer: homeDrawer(context),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: FutureBuilder(
              future: getDisciplina(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Disciplina disciplina = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(disciplina.nome),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () => _excluirDisciplinaDialog(context, disciplina),
                          ),
                        ),
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

  _adicionarDisciplinaDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adicionar Disciplina'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Nome da disciplina"),
                validator: (text){
                  if (text == null || text.isEmpty) {
                    return 'Obrigatório.';
                  }
                  return null;
                },
              )
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('ADICIONAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    Disciplina novaDisciplina = new Disciplina(0, _textFieldController.text, false);
                    setState(() {
                      createDisciplina(novaDisciplina);
                    });
                    Navigator.pop(context);
                    _textFieldController.clear();
                  }
                },
              )
            ],
          );
        });
  }

  _excluirDisciplinaDialog(BuildContext context, Disciplina disciplina) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa disciplina?"),
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
                    deleteDisciplina(disciplina);
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
    // print(todasDisciplinas.toString());
    todasDisciplinas.sort((a,b) => a.nome.compareTo(b.nome));
    return todasDisciplinas;
  }

  void updateDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.updateDisciplina(disciplina);
  }

  void deleteDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.deleteDisciplina(disciplina);
  }

  void createDisciplina(Disciplina disciplina) async {
    await RepositoryServiceDisciplina.addDisciplina(disciplina);
  }
}
