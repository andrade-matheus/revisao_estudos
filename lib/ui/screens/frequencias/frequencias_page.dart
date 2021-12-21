import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/ui/screens/frequencias/adicionar_frequencia_widget/adicionar_frequencia_dialog.dart';
import 'package:revisao_estudos/ui/screens/frequencias/excluir_frequencia_widget/excluir_frequencia_dialog.dart';
import 'package:revisao_estudos/ui/screens/frequencias/info_frequencia_widget/info_frequencia.dart';
import 'package:revisao_estudos/ui/widgets/plano_de_fundo_widget/plano_de_fundo.dart';

class FrequenciasPage extends StatefulWidget {
  @override
  _FrequenciasPageState createState() => _FrequenciasPageState();
}

class _FrequenciasPageState extends State<FrequenciasPage> {
  Color corPrimaria = Colors.blue;
  RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();

  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Frequências",
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline_rounded),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoFrequencia(),
              ),
            );
          },
        ),
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
          future: repositoryFrequencia.obterTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Frequencia> frequencias = snapshot.data;
              return ListView.builder(
                itemCount: frequencias.length,
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
    );
  }
}
