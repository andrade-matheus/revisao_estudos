import 'package:flutter/material.dart';

class DetalhesCard extends StatelessWidget {

  final String title;
  final String text;

  const DetalhesCard({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
                child: ListTile(
                  title: Text(title),
                  subtitle: Flexible(
                    child: Text(text),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
