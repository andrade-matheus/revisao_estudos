
import 'package:flutter/material.dart';
import 'package:revisao_estudos/backup/backup.dart';
import 'package:revisao_estudos/pages/configuracoes/widget/backup/resultado_pop_up.dart';

class CriarBackup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Criar Backup"),
      onTap: () async {
        Backup backup = Backup();
        backup.gerarBackup().then(
            (result){
              if(result) {
                mensagemResultadoBackUp(context, 'O backup foi criado com sucesso.');
              }else {
                mensagemResultadoBackUp(context, 'Não foi possível concluir a criação do backup.');
              }
            }
        );
      },
    );
  }
}
