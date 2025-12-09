import 'package:flutter/material.dart';

class TextFormFieldEmail extends StatelessWidget {
  final TextEditingController emailController;

  final bool isEditing;
  const TextFormFieldEmail({
    super.key,
    required this.emailController,
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
