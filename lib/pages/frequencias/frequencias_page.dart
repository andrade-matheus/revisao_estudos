import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/controllers/frequencia_controller.dart';
import 'package:revisao_estudos/models/classes/frequencia.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/frequencias/widget/adicionar_frequencia_dialog.dart';
import 'package:revisao_estudos/pages/frequencias/widget/excluir_frequencia_dialog.dart';

class FrequenciasPage extends StatefulWidget {
  @override
  _FrequenciasPageState createState() => _FrequenciasPageState();
}

class _FrequenciasPageState extends State<FrequenciasPage> {
  Color corPrimaria = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CalendarioPage()));
          return true;
        },
        child: PlanoDeFundo(
          title: "Frequências de revisões",
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final result = await adicionarFrequenciaDialog(context);
                if (result) {
                  setState(() {});
                }
              },
            ),
          ],
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: FutureBuilder(
              future: FrequenciaController.obterTodasFrequencias(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Frequencia frequencia = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(frequencia.frequencia),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () async {
                              final result = await excluirFrequenciaDialog(
                                  context, frequencia);
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ));
  }
}
