import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/database/repository_service_frequencia.dart';
import 'package:revisao_estudos/models/frequencia.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';

class FrequenciasPage extends StatefulWidget{

  @override
  _FrequenciasPageState createState() => _FrequenciasPageState();
}

class _FrequenciasPageState extends State<FrequenciasPage> {
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
            title: Text("Frequências de revisões"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  final result = _adicionarFrequenciaDialog(context);
                  if(result){
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
              future: getFrequencia(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Frequencia frequencia = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(frequencia.frequencia),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              final result = _excluirFrequenciaDialog(context, frequencia);
                              if(result){
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }

  _adicionarFrequenciaDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adicionar Frequencia'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Nome da frequencia"),
                validator: (text){
                  if (text == null || text.isEmpty) {
                    return 'Obrigatório.';
                  }
                  return null;
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              // Spacer(),
              new FlatButton(
                child: new Text('ADICIONAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    Frequencia novaFrequencia = new Frequencia(0, _textFieldController.text, false);
                    setState(() {
                      createFrequencia(novaFrequencia);
                    });
                    Navigator.pop(context, true);
                    _textFieldController.clear();
                  }
                },
              )
            ],
          );
        });
  }

  _excluirFrequenciaDialog(BuildContext context, Frequencia frequencia) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja mesmo excluir essa frequencia?"),
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
                    deleteFrequencia(frequencia);
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  getFrequencia() async {
    List<Frequencia> todasFrequencias = List();
    todasFrequencias = await RepositoryServiceFrequencia.getAllFrequencias();
    print(todasFrequencias);
    return todasFrequencias;
  }

  void updateFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.updateFrequencia(frequencia);
  }

  void deleteFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.deleteFrequencia(frequencia);
  }

  void createFrequencia(Frequencia frequencia) async {
    await RepositoryServiceFrequencia.addFrequencia(frequencia);
  }
}