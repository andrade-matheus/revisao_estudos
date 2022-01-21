import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/entity/revisao.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/revisoes/detalhes_revisao_page/detalhes_card_widget/detalhes_card.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';

class DetalhesRevisaoPage extends StatefulWidget {
  final Revisao revisao;

  const DetalhesRevisaoPage({
    Key? key,
    required this.revisao,
  }) : super(key: key);

  @override
  _DetalhesRevisaoPageState createState() => _DetalhesRevisaoPageState();
}

class _DetalhesRevisaoPageState extends State<DetalhesRevisaoPage> {
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repositoryDisciplina.obterPorId(widget.revisao.disciplinaId),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            Disciplina? _disciplina = snapshot.data as Disciplina?;
            return Column(
              children: [
                DetalhesCard(
                  title: "Disciplina: ",
                  text: _disciplina?.nome ?? '',
                ),
                DetalhesCard(
                  title: "Nome da revisão: ",
                  text: widget.revisao.nome,
                ),
                DetalhesCard(
                  title: "Frequência: ",
                  text: widget.revisao.frequencia.frequencia,
                ),
                DetalhesCard(
                  title: "Quantidade de revisões concluídas: ",
                  text: widget.revisao.vezesRevisadas.toString(),
                ),
                DetalhesCard(
                  title: "Data do cadastro: ",
                  text: DateFormat('dd / MM / yyyy').format(widget.revisao.dataCadastro),
                ),
                DetalhesCard(
                  title: "Data da próxima revisão: ",
                  text: DateFormat('dd / MM / yyyy').format(widget.revisao.proxRevisao),
                ),
              ],
            );
          } else {
            return Container();
          }
        } else {
          return Carregando();
        }
      },
    );
  }
}
