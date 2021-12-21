import 'package:flutter/material.dart';

class DetalhesCard extends StatelessWidget {

  final String title;
  final String text;

  const DetalhesCard({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(text),
          )
      ),
    );
  }
}
