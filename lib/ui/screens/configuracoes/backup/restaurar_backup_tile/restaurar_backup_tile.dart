import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracao_tile/configuracao_tile.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';
import 'package:revisao_estudos/utils/backup/backup.dart';

class RestaurarBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfiguracaoTile(
      title: "Restaurar Backup",
      onTap: () async {
        bool? confirmacao = await showDialog(
          context: context,
          builder: (context) {
            return DialogoConfirmacao(
              titulo: 'Tem certeza que deseja restaurar um backup?',
              texto: 'Todos os dados não salvos serão apagados!',
            );
          },
        );

        if (confirmacao ?? false) {
          Backup backup = Backup();
          String titulo = '';
          String mensagem = '';
          backup.restoreBackup().then((result) {
            if (result > 0) {
              titulo = 'Sucesso';
              mensagem = 'O backup foi restaurado com sucesso.';
            } else if (result == 0) {
              titulo = 'Ops...';
              mensagem =
                  'A restauração do backup foi cancelada, ou um nenhum arquivo foi selecionado.';
            } else if (result < 0) {
              titulo = 'Erro';
              mensagem = 'Não foi possível finalizar a restauração do backup.';
            }

            showDialog(
              context: context,
              builder: (context) => DialogoConfirmacao(
                titulo: titulo,
                texto: mensagem,
                mensagemUsuario: true,
              ),
            );
          });
        }
      },
    );
  }
}
