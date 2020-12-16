import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/classes/revisao.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';

class DetalhesRevisaoPage extends StatefulWidget {
  final Revisao revisao;

  const DetalhesRevisaoPage(this.revisao);

  @override
  _DetalhesRevisaoPageState createState() => _DetalhesRevisaoPageState();
}

class _DetalhesRevisaoPageState extends State<DetalhesRevisaoPage> {

  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Detalhes da Revisão",
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                      child: ListTile(
                        title: Text("Disciplina: "),
                        subtitle: Flexible(child: Text(this.widget.revisao
                            .disciplina.nome)),
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                      child: ListTile(
                        title: Text("Nome da revisão: "),
                        subtitle: Flexible(
                            child: Text(this.widget.revisao.nome)),
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                      child: ListTile(
                        title: Text("Frequência: "),
                        subtitle: Flexible(child: Text(this.widget.revisao
                            .frequencia.frequencia)),
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                      child: ListTile(
                        title: Text("Quantidade de revisões concluídas: "),
                        subtitle: Flexible(child: Text(this.widget.revisao
                            .vezesRevisadas.toString())),
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Card(
                          child: ListTile(
                            title: Text("Data do cadastro: "),
                            subtitle: Flexible(child: Text(
                                DateFormat('dd / MM / yyyy').format(
                                    this.widget.revisao.dataCadastro))),
                          )
                      ),
                      Card(
                          child: ListTile(
                            title: Text("Data da próxima revisão: "),
                            subtitle: Flexible(child: Text(
                                DateFormat('dd / MM / yyyy').format(
                                    this.widget.revisao.proxRevisao))),
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}