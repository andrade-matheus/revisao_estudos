import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/carregando/carregando.dart';

class DialogoSelecionar<T> extends StatelessWidget {
  final String titulo;
  final Future<List<T>> future;
  final Function(T obejct) texto;
  final Function(T obejct) onTap;

  const DialogoSelecionar({
    Key? key,
    required this.titulo,
    required this.future,
    required this.texto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<T> list = snapshot.data as List<T>;
              return Container(
                height: 300,
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    T object = list[index];
                    return ListTile(
                      title: Text(texto(object)),
                      onTap: () => onTap(object),
                    );
                  },
                ),
              );
            } else {
              return Text('Nenhuma ${T.toString()} foi adicionada ainda.');
            }
          } else {
            return Carregando();
          }
        },
      ),
    );
  }
}
