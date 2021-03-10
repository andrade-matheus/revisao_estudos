import 'package:flutter/material.dart';
import 'package:revisao_estudos/notificacoes/controle_de_notificacoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracaoNotificacao extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const ConfiguracaoNotificacao({Key key, this.sharedPreferences})
      : super(key: key);

  @override
  _ConfiguracaoNotificacaoState createState() =>
      _ConfiguracaoNotificacaoState();
}

class _ConfiguracaoNotificacaoState extends State<ConfiguracaoNotificacao> {
  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreferences = widget.sharedPreferences;
    bool _notificacaoDiaria =
        sharedPreferences.getBool("NOTIFICACAO_DIARIA") ?? true;
    int hora = sharedPreferences.getInt("HORA_NOTIFICACAO") ?? 9;
    int minuto = sharedPreferences.getInt("MINUTOS_NOTIFICACAO") ?? 30;
    return Column(
      children: [
        ListTile(
          title: Text("Notificações diárias"),
          trailing: Switch(
            value: _notificacaoDiaria,
            onChanged: (value) {
              setState(() {
                _notificacaoDiaria = value;
                sharedPreferences.setBool("NOTIFICACAO_DIARIA", _notificacaoDiaria);
                agendarNotificacao();
              });
            },
          ),
        ),
        ListTile(
          title: Text("Horário da notificação"),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Text("${hora > 9 ? hora.toString() : '0' + hora.toString()} : ${minuto > 9 ? minuto.toString() : '0' + minuto.toString()}"),
          ),
          onTap: () async {
            TimeOfDay novoHorario = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (novoHorario != null) {
              setState(() {
                hora = novoHorario.hour;
                minuto = novoHorario.minute;
                sharedPreferences.setInt("HORA_NOTIFICACAO", hora);
                sharedPreferences.setInt("MINUTOS_NOTIFICACAO", minuto);
                agendarNotificacao();
              });
            }
          },
        ),
      ],
    );
  }
}
