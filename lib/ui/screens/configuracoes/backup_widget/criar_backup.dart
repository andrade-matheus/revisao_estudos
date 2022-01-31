import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/resultado_pop_up.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/configuracao_tile/configuracao_tile.dart';
import 'package:revisao_estudos/utils/backup/backup.dart';

class CriarBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfiguracaoTile(
      title: "Criar Backup",
      onTap: () async {
        Backup backup = Backup();
        backup.gerarBackup().then((result) {
          if (result) {
            mensagemResultadoBackUp(
                context, 'O backup foi criado com sucesso.');
          } else {
            mensagemResultadoBackUp(
                context, 'Não foi possível concluir a criação do backup.');
          }
        });
      },
    );
  }
}
