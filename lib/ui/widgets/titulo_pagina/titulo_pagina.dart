import 'package:flutter/material.dart';

class TituloPagina extends StatelessWidget {
  final String titulo;

  const TituloPagina({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
