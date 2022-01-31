import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/confirmacao_restaurar_backup.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/resultado_pop_up.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracao_tile/configuracao_tile.dart';
import 'package:revisao_estudos/utils/backup/backup.dart';

class RestaurarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfiguracaoTile(
      title: "Restaurar Backup",
      onTap: () async {
        bool confirmacao = await confirmacaoRestaurarBackup(context);
        if (confirmacao) {
          Backup backup = Backup();
          backup
              .restoreBackup()
              .then((result) => mensagemResultadoBackUp(context, result));
        }
      },
    );
  }
}
