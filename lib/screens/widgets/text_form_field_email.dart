import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_loja/core/constants/app_constants.dart';

class TextFormFieldEmail extends StatelessWidget {
  const TextFormFieldEmail({required this.emailController, required this.isEditing, super.key});
  final TextEditingController emailController;

  final bool isEditing;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: emailController,
    decoration: const InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email),
    ),
    enabled: isEditing,
    keyboardType: TextInputType.emailAddress,
    autocorrect: false,
    enableSuggestions: false,
    autofillHints: const [AutofillHints.email],
    textInputAction: TextInputAction.next,
    inputFormatters: [
      FilteringTextInputFormatter.deny(Constants.oneOrMoreWhitespaceRegExp), // Remove espaços
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('emailController', emailController));
    properties.add(DiagnosticsProperty<bool>('isEditing', isEditing));
  }
}
