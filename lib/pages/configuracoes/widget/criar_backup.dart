import 'package:flutter/material.dart';
import 'package:revisao_estudos/backup/backup.dart';

class CriarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Criar Backup"),
      onTap: () async {
        var backup = Backup();
        print(await backup.generateBackup());
      },
    );
  }
}
