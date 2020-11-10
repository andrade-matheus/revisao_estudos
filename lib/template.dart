import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/pages/drawer/drawer.dart';

// TEMPLATE PARA PAGES
class TemplatePage extends StatefulWidget {

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text("Template Page"),
        ),
        drawer: homeDrawer(context),
        body: Center()
    );
  }
}

// TEMPLATE PARA WIDGETS
class TemplateWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return null;
  }
}