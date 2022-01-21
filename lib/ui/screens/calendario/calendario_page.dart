import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:revisao_estudos/models/provider/botao_concluir_revisao.dart';
import 'package:revisao_estudos/models/provider/data_selecionada.dart';
import 'package:revisao_estudos/routes/router.gr.dart';
import 'package:revisao_estudos/services/repositories/repository_disciplina.dart';
import 'package:revisao_estudos/ui/screens/calendario/texto_header_widget/texto_header.dart';
import 'package:revisao_estudos/ui/widgets/lista_disciplina/lista_disciplina.dart';
import 'package:revisao_estudos/ui/widgets/revisai_floating_action_button/revisai_floating_action_button.dart';
import 'package:revisao_estudos/utils/date/date_helper.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime _dataSelecionada = DateHelper.hoje();
  Color corPrimaria = Colors.blue;
  RepositoryDisciplina repositoryDisciplina = RepositoryDisciplina();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataSelecionada()),
        ChangeNotifierProvider(create: (_) => BotaoConcluirRevisaoProvider()),
      ],
      builder: (context, _) {
        _dataSelecionada = context.watch<DataSelecionada>().dataSelecionada;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (details) {
            if ((details.primaryVelocity ?? 0) > 0) {
              context.read<DataSelecionada>().reduzirUmDia();
            } else if ((details.primaryVelocity ?? 0) < 0) {
              context.read<DataSelecionada>().aumentarUmDia();
            }
          },
          child: Scaffold(
            floatingActionButton: RevisaiFloatingActionButton(
              onPressed: () => context.router.push(const AdicionarRevisaoRoute()),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoHeader(),
                ListaDisciplina(futureDisciplina: repositoryDisciplina.obterParaCalendario(_dataSelecionada), isCalendario: true),
              ],
            ),
          ),
        );
      },
    );
  }
}
