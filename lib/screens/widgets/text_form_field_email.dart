import 'package:flutter/material.dart';

/// Campo de email com formatação básica e validação opcional.
class TextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailController;
  final String? Function(String?)? validator;

  final bool isEditing;
  const TextFormFieldEmail({
    super.key,
    required this.emailController,
    this.validator,
    required this.isEditing,
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
      validator: validator,
      onChanged: (value) {
        String formatted = value.trim();

        emailController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      },
    );
  }
}
