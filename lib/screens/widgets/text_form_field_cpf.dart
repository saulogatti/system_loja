import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';

class TextFormFieldCpf extends StatelessWidget {
  const TextFormFieldCpf({
    required this.cpfController,
    super.key,
    this.enable = false,
    this.validatorOptions,
  });
  final bool enable;
  final TextEditingController cpfController;
  final String? Function(String?)? validatorOptions;

  @override
  Widget build(BuildContext context) => TextFormField(
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('enable', enable));
    properties.add(DiagnosticsProperty<TextEditingController>('cpfController', cpfController));
    properties.add(
      ObjectFlagProperty<String? Function(String?)?>.has('validatorOptions', validatorOptions),
    );
  }
}
