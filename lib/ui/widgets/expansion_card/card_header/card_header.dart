import 'package:flutter/material.dart';
import 'package:revisao_estudos/ui/widgets/expansion_card/card_header/card_title/card_title.dart';
import 'package:revisao_estudos/ui/widgets/expansion_card/card_header/expand_arrow/expand_arrow.dart';

class CardHeader extends StatefulWidget {
  final String? title;
  final TextStyle? titleStyle;
  final bool isExpanded;
  final EdgeInsets? titlePadding;

  const CardHeader({
    Key? key,
    this.title,
    this.isExpanded = false,
    this.titlePadding,
    this.titleStyle,
  }) : super(key: key);

  @override
  _CardHeaderState createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.titlePadding ??
          EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: CardTitle(
              title: widget.title,
            ),
          ),
          ExpandArrow(
            isExpanded: widget.isExpanded,
          ),
        ],
      ),
    );
  }
}
