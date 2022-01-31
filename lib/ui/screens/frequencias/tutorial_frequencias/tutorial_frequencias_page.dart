import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/ui/screens/frequencias/tutorial_frequencias/botao_voltar/botao_voltar.dart';
import 'package:revisao_estudos/ui/screens/frequencias/tutorial_frequencias/mostra_frequencia/mostra_frequencia.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';

class TutorialFrequenciasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TituloPagina(
            titulo: 'Frequências',
            voltar: true,
          ),
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'A frequência é a frequência em dias que suas revisões vão acontecer.\n\n',
                      ),
                      TextSpan(
                        text: 'Por Exemplo:\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Para ter a primeira revisão de um conteúdo daqui uma semana, e a segunda revisão duas semanas após a primeira revisão, a frequência a se utilizar seria:',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                MostraFrequencia(
                  frequencia: Frequencia(
                    id: 0,
                    frequencia: '07-14',
                  ),
                ),
                Text(
                  'Caso queira começar revisar ainda hoje ou amanhã, basta utilizar as seguintes frequências respectivamente:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                MostraFrequencia(
                  frequencia: Frequencia(
                    id: 0,
                    frequencia: '00-07-14',
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                ),
                MostraFrequencia(
                  frequencia: Frequencia(
                    id: 0,
                    frequencia: '01-07-14',
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Atenção:\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Sua frequência não pode conter apenas zeros, e nem terminar em zero. E lembre-se, o último valor da sua frequência se repete para sempre.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BotaoVoltar(),
        ],
      ),
    );
  }
}
