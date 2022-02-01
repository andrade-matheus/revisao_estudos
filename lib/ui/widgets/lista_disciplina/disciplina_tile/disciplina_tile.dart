import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/disciplina_tile/expansion_card/expansion_card_widget.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_revisoes/lista_revisoes.dart';

class DisciplinaTile extends StatefulWidget{
  final Disciplina disciplina;
  final DateTime? data;

  const DisciplinaTile({
    Key? key,
    required this.disciplina,
    this.data,
  }) : super(key: key);

  @override
  State<DisciplinaTile> createState() => _DisciplinaTileState();
}

class _DisciplinaTileState extends State<DisciplinaTile> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // Necessário para o AutomaticKeepAliveClientMixin.
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ExpansionCard(
        title: widget.disciplina.nome,
        initiallyExpanded: true,
        child: ListaRevisoes(
          disciplina: widget.disciplina,
          data: widget.data,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
