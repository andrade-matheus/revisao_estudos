import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/drawer/drawer.dart';

class PlanoDeFundo extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;
  final Widget leading;
  final FloatingActionButton floatingActionButton;

  const PlanoDeFundo({
    Key key,
    this.child,
    this.title,
    this.actions,
    this.leading,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton,
        appBar: AppBar(
          title: Text(title),
          actions: actions,
          leading: leading,
        ),
        drawer: homeDrawer(context),
        body: child,
      ),
    );
  }
}
