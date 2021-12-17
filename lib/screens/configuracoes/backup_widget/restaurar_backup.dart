import 'package:flutter/material.dart';
import 'package:revisao_estudos/screens/configuracoes/backup_widget/confirmacao_restaurar_backup.dart';
import 'package:revisao_estudos/screens/configuracoes/backup_widget/resultado_pop_up.dart';
import 'package:revisao_estudos/utils/backup/backup.dart';

class RestaurarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Restaurar Backup"),
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
