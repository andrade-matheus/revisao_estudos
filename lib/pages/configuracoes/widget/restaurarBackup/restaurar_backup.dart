import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/backup/backup.dart';
import 'package:revisao_estudos/pages/configuracoes/widget/restaurarBackup/confirmacao_restaurar_backup.dart';

class RestaurarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Restaurar Backup"),
      onTap: () async {
        FilePickerResult result = await FilePicker.platform.pickFiles();
        if(result != null) {
          bool confirmacao = await confirmacaoRestaurarBackup(context);
          if(confirmacao){
            Backup backup = Backup();
            String path = result.files.single.path;
            await backup.restoreBackup(path);
          }
        }
      },
    );
  }
}
