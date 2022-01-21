import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/frequencia.dart';
import 'package:revisao_estudos/services/repositories/repository_frequencia.dart';
import 'package:revisao_estudos/ui/screens/frequencias/excluir_frequencia_widget/excluir_frequencia_dialog.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';

class FrequenciasPage extends StatefulWidget {
  @override
  _FrequenciasPageState createState() => _FrequenciasPageState();
}

class _FrequenciasPageState extends State<FrequenciasPage> {
  Color corPrimaria = Colors.blue;
  RepositoryFrequencia repositoryFrequencia = RepositoryFrequencia();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder(
        future: repositoryFrequencia.obterTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              List<Frequencia> frequencias = snapshot.data as List<Frequencia>;
              return ListView.builder(
                itemCount: frequencias.length,
                itemBuilder: (context, index) {
                  Frequencia frequencia = frequencias[index];
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
              return Container();
            }
          } else {
            return Carregando();
          }
        },
      ),
    );
  }
}
