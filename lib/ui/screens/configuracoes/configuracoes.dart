import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/criar_backup.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/backup_widget/restaurar_backup.dart';
import 'package:revisao_estudos/ui/screens/configuracoes/notificacao_widget/configuracao_notificacao.dart';
import 'package:revisao_estudos/ui/widgets/plano_de_fundo_widget/plano_de_fundo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return PlanoDeFundo(
      title: "Configurações",
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final SharedPreferences sharedPreferences = snapshot.data;
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
      ),
    );
  }
}
