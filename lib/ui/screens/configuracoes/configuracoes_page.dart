import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/criar_backup.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/restaurar_backup.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/notificacao_widget/configuracao_notificacao.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfiguracoesPage extends StatefulWidget {
  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final SharedPreferences sharedPreferences = snapshot.data as SharedPreferences;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView(
              children: [
                ConfiguracaoNotificacao(sharedPreferences: sharedPreferences),
                CriarBackup(),
                RestaurarBackup(),
              ],
            ),
          );
        } else {
          return Column();
        }
      },
    );
  }
}
