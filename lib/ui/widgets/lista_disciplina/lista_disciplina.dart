import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/disciplina_tile/disciplina_tile.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/sem_revisoes/sem_revisoes.dart';

class ListaDisciplina extends StatelessWidget {
  final Future<List<Disciplina>> futureDisciplina;
  final DateTime? data;

  const ListaDisciplina({
    Key? key,
    required this.futureDisciplina,
    this.data,
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
              return SemRevisoes(data: data,);
            } else {
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 80),
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: disciplinas.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = disciplinas[index];
                  return DisciplinaTile(
                    disciplina: disciplina,
                    data: data,
                  );
                },
              );
            }
          } else {
            return Carregando();
          }
        },
      ),
    );
  }
}
