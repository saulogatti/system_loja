import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_loja/aplication/utils/constants.dart';

class TextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailController;

  final bool isEditing;
  const TextFormFieldEmail({
    required this.emailController,
    required this.isEditing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      enabled: isEditing,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          Constants.oneOrMoreWhitespaceRegExp,
        ), // Remove espaços
        FilteringTextInputFormatter.deny(Constants.accentedCharsRegExp),
      ],
      validator: (value) {
        if (value != null && value.trim().isNotEmpty) {
          if (!Constants.emailRegExp.hasMatch(value.trim())) {
            return 'Email inválido';
          }
        }
        return null;
      },
    );
  }
}
