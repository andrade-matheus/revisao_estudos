import 'dart:math';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_fontes.dart';

class CardHeader extends StatefulWidget {
  final Widget? leading;
  final Widget? header;
  final String? title;
  final bool isExpanded;

  const CardHeader({
    Key? key,
    this.leading,
    this.title,
    this.header,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  _CardHeaderState createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> with TickerProviderStateMixin {
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
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          widget.leading ?? Container(),
          Expanded(
            child: Text(
              widget.title ?? '',
              style: TextStyle(
                color: AppColors.preto,
                fontFamily: AppFontes.robotoBold,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          AnimatedBuilder(
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
          ),
        ],
      ),
    );
  }
}