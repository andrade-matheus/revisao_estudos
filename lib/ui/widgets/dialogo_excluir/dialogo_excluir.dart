import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';

class ExcluirDialog extends StatelessWidget {
  final String entidade;
  final bool utilizada;

  const ExcluirDialog({
    Key? key,
    required this.entidade,
    required this.utilizada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titulo = "Deseja mesmo excluir essa $entidade?";
    String texto = utilizada
        ? 'A $entidade possui revisões, se optar por exclui-la, todas as revisões vinculadas támbem serão excluídas.'
        : 'A $entidade não possui nenhuma revisão vinculada a ela.';

    return DialogoConfirmacao(
      titulo: titulo,
      texto: texto,
      textoBotaoConfirmar: 'EXCLUIR',
    );
  }
}
