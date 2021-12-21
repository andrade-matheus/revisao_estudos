import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/plano_de_fundo/plano_de_fundo.dart';

class InfoFrequencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: 'Formato da frequência',
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Como escrever sua frequência:\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'A frequência é a frequência em dias que suas revisões vão acontecer.',
                  ),
                  TextSpan(
                    text:
                        '\n\nPor exemplo: se pretende fazer a primeira revisão daqui uma semana, e a segunda revisão duas semanas depois da primeira revisão, a frequência seria:',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: '\n"7-14"',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text:
                        '\n\nSe quiser fazer a revisão ainda hoje ou amanhã basta fazer a frequência assim:',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: '\n "0-7-14" ou "1-7-14"',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text:
                        '\n\n "0" referenciando zero dias a partir de hoje, ou seja ainda hoje.',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text:
                        '\n "1" referenciando um dia a partir de hoje, ou seja amanhã.',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: '\n\nEla não deve:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '\n  - Ser apenas "0"',
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: '\n  - Terminar em zero, por exemplo "7-14-0"',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
