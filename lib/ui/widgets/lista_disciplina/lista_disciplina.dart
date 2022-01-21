import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/disciplina_tile/disciplina_tile.dart';
import 'package:revisao_estudos/ui/widgets/sem_revisoes/sem_revisoes.dart';

class ListaDisciplina extends StatelessWidget {
  final Future<List<Disciplina>> futureDisciplina;
  final bool isCalendario;

  const ListaDisciplina({
    Key? key,
    required this.futureDisciplina,
    required this.isCalendario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Disciplina> disciplinas = [];
    return Expanded(
      child: FutureBuilder(
        future: futureDisciplina,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            disciplinas = (snapshot.data ?? []) as List<Disciplina>? ?? [];
            if (disciplinas.isEmpty) {
              return SemRevisoes();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 80),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: disciplinas.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = disciplinas[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: DisciplinaTile(
                      disciplina: disciplina,
                      isCalendario: isCalendario,
                    ),
                  );
                },
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}