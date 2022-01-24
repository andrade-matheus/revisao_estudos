import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class RevisaoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool? showCursor;
  final bool? readOnly;
  final bool? enableInteractiveSelection;

  const RevisaoTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onTap,
    this.showCursor,
    this.readOnly,
    this.keyboardType,
    this.enableInteractiveSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextFormField(
          showCursor: showCursor,
          readOnly: readOnly ?? false,
          textCapitalization: TextCapitalization.sentences,
          enableInteractiveSelection: enableInteractiveSelection ?? true,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            fillColor: AppColors.backgroundTextField,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bordaTextField),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.preto,
              fontWeight: FontWeight.w300
            )
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Obrigatório.';
            }
            return null;
          },
          onTap: onTap,
        ),
      ),
    );
  }
}
