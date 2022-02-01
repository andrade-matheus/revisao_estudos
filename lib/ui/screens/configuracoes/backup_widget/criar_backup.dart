import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracao_tile/configuracao_tile.dart';
import 'package:revisao_estudos/ui/widgets/dialogo_confirmacao/dialogo_confirmacao.dart';
import 'package:revisao_estudos/utils/backup/backup.dart';

class CriarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfiguracaoTile(
      title: "Criar Backup",
      onTap: () async {
        Backup backup = Backup();
        String titulo = '';
        String mensagem = '';
        backup.gerarBackup().then((result) {
          if (result != null) {
            titulo = 'Sucesso';
            mensagem = 'O backup foi criado com sucesso na pasta "$result"';
          } else {
            titulo = 'Ops...';
            mensagem = 'Não foi possível concluir a criação do backup.';
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
      },
    );
  }
}
