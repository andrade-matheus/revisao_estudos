import 'package:flutter/material.dart';
import 'package:revisao_estudos/pages/PlanoDeFundo/plano_de_fundo.dart';
import 'package:revisao_estudos/pages/configuracoes/widget/criar_backup.dart';
import 'package:revisao_estudos/pages/configuracoes/widget/configuracao_notificacao.dart';
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
                  ConfiguracaoNotificacao(
                    sharedPreferences: sharedPreferences,
                  ),
                  CriarBackup(),

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
