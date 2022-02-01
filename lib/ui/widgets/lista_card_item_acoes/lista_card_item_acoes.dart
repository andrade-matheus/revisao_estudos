import 'package:flutter/material.dart';
import 'package:revisao_estudos/models/entity/disciplina.dart';
import 'package:revisao_estudos/models/interface/entity_common.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';
import 'package:revisao_estudos/ui/widgets/lista_card_item_acoes/card_item_acoes/card_item_acoes.dart';

class ListaCardItemAcoes<T extends EntityCommon> extends StatefulWidget {
  final List<T> itens;
  final AcoesItemCallback? onPressedEditar;
  final AcoesItemCallback? onPressedExcluir;

  const ListaCardItemAcoes({
    Key? key,
    required this.itens,
    this.onPressedEditar,
    this.onPressedExcluir,
  }) : super(key: key);

  @override
  _ListaCardItemAcoesState<T> createState() => _ListaCardItemAcoesState<T>();
}

class _ListaCardItemAcoesState<T extends EntityCommon>
    extends State<ListaCardItemAcoes> {
  Map<int, GlobalKey<CardItemAcoesState<T>>> _keysListCard = {};
  int? _currentId;

  @override
  Widget build(BuildContext context) {
    if (widget.itens.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 80),
        itemCount: widget.itens.length,
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) {
          T item = widget.itens[index] as T;
          GlobalKey<CardItemAcoesState<T>> _key = GlobalKey<CardItemAcoesState<T>>();
          _keysListCard[item.id] = _key;

          return CardItemAcoes<T>(
            key: _key,
            item: item,
            currentIdCallback: (id) => _currentIdCallback(id),
            onPressedEditar: widget.onPressedEditar,
            onPressedExcluir: widget.onPressedExcluir,
          );
        },
      );
    } else {
      return Center(
        child: Text(
          'Nenhuma ${(T == Disciplina) ? 'disciplina' : 'frequência'} foi adicionada ainda.',
          style: TextStyle(
            fontSize: 20
          ),
        ),
      );
    }
  }

  int? _currentIdCallback(int? id) {
    if (id != null) {
      // Atualizando id
      int? _idAnterior = _currentId;
      _currentId = id;

      // Verficando estado do id anterior
      GlobalKey<CardItemAcoesState<T>>? _auxKey = _keysListCard[_idAnterior];
      if (_auxKey != null) {
        _auxKey.currentState?.verficarEstadoBotoes();
      }

      // Verficando estado do novo id
      _auxKey = _keysListCard[_currentId];
      if (_auxKey != null) {
        _auxKey.currentState?.verficarEstadoBotoes();
      }
    }
    return _currentId;
  }
}
