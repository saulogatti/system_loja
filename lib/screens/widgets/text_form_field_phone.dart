import 'package:flutter/material.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';

class TextFormFieldPhone extends StatelessWidget {
  const TextFormFieldPhone({
    required this.telefoneController,
    required this.isEditing,
    super.key,
  });

  final TextEditingController telefoneController;
  final bool isEditing;

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
      autofillHints: const [AutofillHints.telephoneNumber],
      textInputAction: TextInputAction.next,
      inputFormatters: [PhoneTextInputFormatter()],
    );
  }
}
