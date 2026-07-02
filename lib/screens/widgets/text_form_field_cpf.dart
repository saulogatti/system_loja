import 'package:flutter/material.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';

class TextFormFieldCpf extends StatelessWidget {
  final bool enable;
  final TextEditingController cpfController;
  final String? Function(String?)? validatorOptions;
  const TextFormFieldCpf({
    required this.cpfController,
    super.key,
    this.enable = false,
    this.validatorOptions,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cpfController,
      decoration: const InputDecoration(
        labelText: 'CPF',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.badge),
      ),
      enabled: enable, // CPF cannot be changed
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: false,
      inputFormatters: [CpfTextInputFormatter()],
      validator: validatorOptions,
    );
  }
}
