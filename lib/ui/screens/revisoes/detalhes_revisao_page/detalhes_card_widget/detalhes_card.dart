import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class DetalhesCard extends StatelessWidget {
  final String title;
  final String text;

  const DetalhesCard({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 2),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.laranjaBordaCard,
                )
              )
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.preto,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.preto,
              fontWeight: FontWeight.w400,
              fontSize: 18
            ),
          ),
        ],
      ),
    );
  }
}
