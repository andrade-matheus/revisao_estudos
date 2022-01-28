import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';

class AdicionarEditarDisciplinaDialog extends StatelessWidget {
  final String titulo;
  final String? botaoConfirmar;
  final String? botaoCancelar;
  final Function(String nomeDisciplina) onPressed;

  const AdicionarEditarDisciplinaDialog({
    Key? key,
    required this.titulo,
    this.botaoConfirmar,
    this.botaoCancelar,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(titulo),
      content: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _textFieldController,
          decoration: InputDecoration(
            hintText: "Nome da disciplina",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.underlinePadraoTextField,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.underlinePadraoTextField,
                width: 1,
              ),
            ),

          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Obrigatório.';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text(botaoCancelar ?? 'CANCELAR'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        // Spacer(),
        new TextButton(
          child: new Text(botaoConfirmar ?? 'CONFIRMAR'),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              onPressed(_textFieldController.text);
              Navigator.pop(context, true);
              _textFieldController.clear();
            }
          },
        )
      ],
    );
  }
}
