import 'dart:math';

import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class ExpandArrow extends StatefulWidget {
  final bool isExpanded;

  const ExpandArrow({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  _ExpandArrowState createState() => _ExpandArrowState();
}

class _ExpandArrowState extends State<ExpandArrow>
    with TickerProviderStateMixin {
  late Animation _arrowAnimation;
  late AnimationController _arowAnimationController;

  @override
  void initState() {
    super.initState();
    _arowAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
    _arrowAnimation =
        Tween<double>(begin: 0.0, end: pi).animate(_arowAnimationController)
          ..addListener(() {
            setState(() {
              if (widget.isExpanded) {
                _arowAnimationController.forward();
              } else {
                _arowAnimationController.reverse();
              }
            });
          });
    _arowAnimationController.forward();
  }

  @override
  void dispose() {
    _arowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isExpanded
        ? _arowAnimationController.forward()
        : _arowAnimationController.reverse();

    return AnimatedBuilder(
      animation: _arowAnimationController,
      child: Icon(
        Icons.expand_more,
        color: AppColors.preto,
        size: 24,
      ),
      builder: (context, _child) {
        return Transform.rotate(
          angle: _arrowAnimation.value,
          child: _child,
        );
      },
    );
  }
}
