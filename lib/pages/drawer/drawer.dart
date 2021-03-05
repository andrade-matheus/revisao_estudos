import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/pages/calendario/calendario_page.dart';
import 'package:revisao_estudos/pages/configuracoes/configuracoes.dart';
import 'package:revisao_estudos/pages/disciplinas/disciplinas_page.dart';
import 'package:revisao_estudos/pages/frequencias/frequencias_page.dart';
import 'file:///C:/Users/mat_1/AndroidStudioProjects/revisao_estudos/lib/pages/revisoes/revisaoPage/revisoes_page.dart';

Widget homeDrawer(BuildContext context){
  Color corPrimaria = Colors.blue;

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Text(
              "Revisão \n dos seus estudos",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
          decoration: BoxDecoration(
              color: corPrimaria
          ),
        ),
        ListTile(
          title: Text("Calendário"),
          leading: Icon(Icons.calendar_today),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CalendarioPage())
            );
          },
        ),
        ListTile(
          title: Text("Revisões"),
          leading: Icon(Icons.bookmark_border_outlined),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RevisoesPage())
            );
          },
        ),
        ListTile(
          title: Text("Disciplinas"),
          leading: Icon(Icons.class__outlined),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DisciplinasPage())
            );
          },
        ),
        ListTile(
          title: Text("Frequências de revisão"),
          leading: Icon(Icons.repeat_outlined),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => FrequenciasPage())
            );
          },
        ),
        ListTile(
          title: Text("Configurações"),
          leading: Icon(Icons.settings),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Configuracoes())
            );
          },
        ),
      ],
    ),
  );
}