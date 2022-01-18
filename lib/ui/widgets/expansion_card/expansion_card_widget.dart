import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/ui/widgets/expansion_card/card_header.dart';

class ExpansionCard extends StatefulWidget {
  final Widget? leading;
  final Widget? header;
  final String? title;
  final bool initiallyExpanded;
  final Widget? child;

  const ExpansionCard({
    this.leading,
    this.header,
    this.title,
    this.initiallyExpanded = false,
    required this.child,
  });

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _exapandAnimation;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _exapandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
    isExpanded ? _expandController.forward() : _expandController.reverse();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: ShapeDecoration(
          shadows: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0,3),
            ),
          ],
          color: AppColors.branco,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.laranjaBordaCard,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
        child: Column(
          children: [
            CardHeader(
              leading: widget.leading,
              title: widget.title,
              header: widget.header,
              isExpanded: isExpanded,
            ),
            SizeTransition(
              sizeFactor: _exapandAnimation,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: widget.child,
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          isExpanded
              ? _expandController.forward()
              : _expandController.reverse();
        });
      },
    );
  }
}