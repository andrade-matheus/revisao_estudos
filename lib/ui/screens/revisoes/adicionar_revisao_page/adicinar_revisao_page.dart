import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_revisao.dart';
import 'package:revisao_estudos/ui/screens/revisoes/adicionar_revisao_page/revisao_text_field/revisao_text_field.dart';
import 'package:revisao_estudos/ui/screens/revisoes/botao_revisao/botao_revisao.dart';
import 'package:revisao_estudos/ui/widgets/date_picker/date_picker.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_selecionar/dialogo_selecionar.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

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
  late Disciplina disciplinaSelecinada;
  late Frequencia frequenciaSelecionada;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            TituloPagina(
              titulo: 'Nova revisão',
              voltar: true,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      RevisaoTextField(
                        controller: _assuntoTextField,
                        labelText: "Assunto",
                        hintText: "Assunto da revisão",
                      ),
                    ],
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      RevisaoTextField(
                        showCursor: true,
                        readOnly: true,
                        controller: _disciplinaTextField,
                        labelText: "Disciplina",
                        hintText: "Disciplina",
                        onTap: () => _escolherDisciplinaDialog(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RevisaoTextField(
                        showCursor: true,
                        readOnly: true,
                        controller: _frequenciaTextField,
                        labelText: "Frequência",
                        hintText: "Frequência",
                        onTap: () => _escolherFrequenciaDialog(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RevisaoTextField(
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.number,
                        controller: _vezesRevisadasTextField,
                        labelText: "Vezes Revisadas",
                        hintText: "Número de revisões já realizada",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RevisaoTextField(
                        showCursor: true,
                        readOnly: true,
                        controller: _dataTextField,
                        labelText: "Data",
                        hintText: DateFormat('dd / MM / yyyy')
                            .format(DateHelper.hoje()),
                        onTap: () => _escolherDataDialog(context),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Row(
                      children: [
                        BotaoRevisao(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          texto: 'Cancelar',
                          onPressed: () {
                            context.router.pop();
                          },
                          backgroudColor: AppColors.botaoNovaRevisaoCancelar,
                        ),
                        BotaoRevisao(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          texto: 'Salvar',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                Revisao novaRevisao = gerarNovaRevisao();
                                repositoryRevisao.adicionar(novaRevisao);
                              });
                              Navigator.pop(context, true);
                            }
                          },
                          backgroudColor: AppColors.botaoNovaRevisaoSalvar,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _escolherDisciplinaDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return DialogoSelecionar<Disciplina>(
          titulo: 'Escolha uma Disciplina',
          future: repositoryDisciplina.obterTodos(),
          texto: (disciplina) => disciplina.nome,
          onTap: (Disciplina disciplina) {
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
    );
  }

  _escolherFrequenciaDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return DialogoSelecionar<Frequencia>(
          titulo: 'Escolha uma Frequência',
          future: repositoryFrequencia.obterTodos(),
          texto: (frequecia) => frequecia.frequencia,
          onTap: (Frequencia frequencia) {
            setState(() {
              frequenciaSelecionada = frequencia;
              _frequenciaTextField.value = TextEditingValue(
                text: frequencia.frequencia,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: frequencia.frequencia.length),
                ),
              );
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  _escolherDataDialog(BuildContext context) async {
    DateTime? dataEscolhida = await escolherDataDialog(context, dataSelecionada);
    if(dataEscolhida != null){
      setState(() {
        dataSelecionada = dataEscolhida;
      });
    }
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
      disciplinaId: disciplinaSelecinada.id,
      frequencia: frequenciaSelecionada,
      dataCadastro: dataSelecionada,
      proxRevisao: dataSelecionada.add(Duration(days: diasProxRevisao)),
      vezesRevisadas: int.parse(_vezesRevisadasTextField.text),
      isArchived: false,
    );

    return revisao;
  }
}
