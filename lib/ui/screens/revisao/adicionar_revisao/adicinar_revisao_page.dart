import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/widgets/date_picker/date_picker.dart';
import 'package:revisao_estudos/ui/widgets/plano_de_fundo_widget/plano_de_fundo.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

// TODO : Refatorar esse classe, ta muito grande.

class AdicionarRevisaoPage extends StatefulWidget {
  @override
  _AdicionarRevisaoPageState createState() => _AdicionarRevisaoPageState();
}

class _AdicionarRevisaoPageState extends State<AdicionarRevisaoPage> {
  TextEditingController _assuntoTextField = TextEditingController();
  TextEditingController _disciplinaTextField = TextEditingController();
  TextEditingController _frequenciaTextField = TextEditingController();
  TextEditingController _vezesRevisadasTextField = TextEditingController();
  TextEditingController _dataTextField = TextEditingController();

  DateTime dataSelecionada = DateHelper.hoje();
  Disciplina disciplinaSelecinada;
  Frequencia frequenciaSelecionada;

  final _formKey = GlobalKey<FormState>();

  RepositoryRevisao repositoryRevisao = RepositoryRevisao();
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();
  RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();

  Color corPrimaria = Colors.blue;

  @override
  void initState() {
    dataSelecionada = DateHelper.hoje();

    _vezesRevisadasTextField.value = TextEditingValue(
        text: "0",
        selection:
            TextSelection.fromPosition(TextPosition(offset: "0".length)));

    String data = DateFormat('dd / MM / yyyy').format(dataSelecionada);
    _dataTextField.value = TextEditingValue(
        text: data,
        selection:
            TextSelection.fromPosition(TextPosition(offset: data.length)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Nova Revisão",
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _assuntoTextField,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: "Assunto",
                            hintText: "Assunto da revisão"),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        showCursor: true,
                        readOnly: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: _disciplinaTextField,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: "Disciplina",
                            hintText: "Disciplina"),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Obrigatório.';
                          }
                          return null;
                        },
                        onTap: () => _escolherDisciplinaDialog(context),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        showCursor: true,
                        readOnly: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: _frequenciaTextField,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: "Frequência",
                            hintText: "Frequência"),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Obrigatório.';
                          }
                          return null;
                        },
                        onTap: () => _escolherFrequenciaDialog(context),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.number,
                        controller: _vezesRevisadasTextField,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: "Vezes Revisadas",
                            hintText: "0"),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        showCursor: true,
                        readOnly: true,
                        controller: _dataTextField,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: "Data",
                            hintText: DateFormat('dd / MM / yyyy')
                                .format(DateHelper.hoje())),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Obrigatório.';
                          }
                          return null;
                        },
                        onTap: () => _escolherDataDialog(context),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              Revisao novaRevisao = gerarNovaRevisao();
                              repositoryRevisao.adicionar(novaRevisao);
                            });
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text("Salvar")),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _escolherDisciplinaDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Escolher Disciplina'),
          content: FutureBuilder(
            future: repositoryDisciplina.obterTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: 300,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Disciplina disciplina = snapshot.data[index];
                      return ListTile(
                        title: Text(disciplina.nome),
                        onTap: () {
                          setState(() {
                            disciplinaSelecinada = disciplina;
                            _disciplinaTextField.value = TextEditingValue(
                              text: disciplina.nome,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: disciplina.nome.length),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }

  _escolherFrequenciaDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Escolher Frequência'),
          content: FutureBuilder(
            future: repositoryFrequencia.obterTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: 300,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Frequencia frequencia = snapshot.data[index];
                      return ListTile(
                        title: Text(frequencia.frequencia),
                        onTap: () {
                          setState(() {
                            frequenciaSelecionada = frequencia;
                            _frequenciaTextField.value = TextEditingValue(
                              text: frequencia.frequencia,
                              selection: TextSelection.fromPosition(
                                TextPosition(
                                    offset: frequencia.frequencia.length),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              } else {
                return Column();
              }
            },
          ),
        );
      },
    );
  }

  _escolherDataDialog(BuildContext context) async {
    DateTime dataEscolhida = await escolherDataDialog(context, dataSelecionada);
    setState(() {
      dataSelecionada = dataEscolhida ?? dataSelecionada;
    });
    String dataStr = DateFormat('dd / MM / yyyy').format(dataSelecionada);
    _dataTextField.value = TextEditingValue(
      text: dataStr,
      selection: TextSelection.fromPosition(
        TextPosition(offset: dataStr.length),
      ),
    );
  }

  Revisao gerarNovaRevisao() {
    Revisao revisao;

    List<String> valoresFrequencia = _frequenciaTextField.text.split('-');
    int vezesRevisadas = int.parse(_vezesRevisadasTextField.text);

    if (vezesRevisadas >= valoresFrequencia.length) {
      vezesRevisadas = valoresFrequencia.length - 1;
    }

    int diasProxRevisao = int.parse(valoresFrequencia[vezesRevisadas]);

    revisao = Revisao(
      id: 0,
      nome: _assuntoTextField.text,
      disciplina: disciplinaSelecinada,
      frequencia: frequenciaSelecionada,
      dataCadastro: dataSelecionada,
      proxRevisao: dataSelecionada.add(Duration(days: diasProxRevisao)),
      vezesRevisadas: int.parse(_vezesRevisadasTextField.text),
      isArchived: false,
    );

    return revisao;
  }
}
