import 'package:flutter/material.dart';

class DisciplinaTile extends StatelessWidget {
  final String title;
  final Widget child;

  const DisciplinaTile({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      initiallyExpanded: true,
      children: [
        child,
      ],
    );
  }
}
