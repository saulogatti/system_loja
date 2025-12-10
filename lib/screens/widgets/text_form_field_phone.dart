import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/text_formatters.dart';

/// Campo de telefone com formatação e validação opcional.
class TextFormFieldPhone extends StatelessWidget {
  const TextFormFieldPhone({
    super.key,
    required this.telefoneController,
    required this.isEditing,
    this.validator,
  });

  final TextEditingController telefoneController;
  final bool isEditing;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: telefoneController,
      decoration: const InputDecoration(
        labelText: 'Telefone',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
      enabled: isEditing,
      keyboardType: TextInputType.phone,
      inputFormatters: [PhoneTextInputFormatter()],
      validator: validator,
    );
  }
}
