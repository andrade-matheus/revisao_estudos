import 'package:flutter/material.dart';
import 'package:revisao_estudos/backup/backup.dart';
import 'package:revisao_estudos/pages/configuracoes/widget/backup/confirmacao_restaurar_backup.dart';

class RestaurarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Restaurar Backup"),
      onTap: () async {
        bool confirmacao = await confirmacaoRestaurarBackup(context);
        if (confirmacao) {
          Backup backup = Backup();
          await backup.restoreBackup();
        }
      },
    );
  }
}
