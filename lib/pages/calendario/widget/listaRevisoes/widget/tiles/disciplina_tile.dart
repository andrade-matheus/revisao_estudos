import 'package:flutter/material.dart';

class DisciplinaTile extends StatelessWidget {
  final String title;
  final Widget child;

  const DisciplinaTile({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      children: [
        child,
      ],
    );
  }
}
