import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup/criar_backup_tile/criar_backup_tile.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup/restaurar_backup_tile/restaurar_backup_tile.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/notificacao_widget/configuracao_notificacao.dart';
import 'package:revisao_estudos/ui/widgets/titulo_pagina/titulo_pagina.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            TituloPagina(
              titulo: 'Configurações',
            ),
            FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final SharedPreferences sharedPreferences =
                      snapshot.data as SharedPreferences;
                  return Column(
                    children: [
                      ConfiguracaoNotificacao(sharedPreferences: sharedPreferences),
                      CriarBackupTile(),
                      RestaurarBackupTile(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
