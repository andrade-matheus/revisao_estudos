import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/ui/screens/frequencias/adicionar_frequencia_dialog/adicionar_frequencia_dialog.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_excluir/dialogo_excluir.dart';
import 'package:revisao_estudos/ui/widgets/lista_card_item_acoes/lista_card_item_acoes.dart';
import 'package:revisao_estudos/ui/widgets/revisai_floating_action_button/revisai_floating_action_button.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class FrequenciasPage extends StatefulWidget {
  @override
  _FrequenciasPageState createState() => _FrequenciasPageState();
}

class _FrequenciasPageState extends State<FrequenciasPage> {
  Color corPrimaria = Colors.blue;
  RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RevisaiFloatingActionButton(
        onPressed: () => adicionarFrequencia(),
      ),
      body: Column(
        children: [
          TituloPagina(
            titulo: 'Suas frequências',
            padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
          ),
          FutureBuilder(
            future: repositoryFrequencia.obterTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Frequencia> frequencias =
                      snapshot.data as List<Frequencia>;
                  return Expanded(
                    child: ListaCardItemAcoes(
                      itens: frequencias,
                      onPressedExcluir: (frequencia) =>
                          excluirFrequencia(frequencia as Frequencia),
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Carregando();
              }
            },
          ),
        ],
      ),
    );
  }

  adicionarFrequencia() async {
    var updateState = await showDialog(
      context: context,
      builder: (context) {
        return AdicionarFequenciaDialog();
      },
    );

    if (updateState ?? false) {
      setState(() {});
    }
  }

  excluirFrequencia(Frequencia frequencia) async {
    RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
    bool utilizada = await repositoryFrequencia.utilizado(frequencia.id);

    var updateState = await showDialog(
      context: context,
      builder: (context) {
        return ExcluirDialog(
          entidade: 'frequência',
          utilizada: utilizada,
          onPressed: () async {
            RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();
            bool resultado =
                await repositoryFrequencia.remover(frequencia.id, force: true);
            Navigator.pop(context, resultado);
          },
        );
      },
    );

    if (updateState ?? false) {
      setState(() {});
    }
  }
}
