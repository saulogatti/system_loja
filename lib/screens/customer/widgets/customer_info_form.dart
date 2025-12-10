import 'package:flutter/material.dart';
import 'package:system_loja/screens/widgets/text_form_field_cpf.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

/// Formulário para edição das informações pessoais do cliente.
class CustomerInfoForm extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController enderecoController;

  const CustomerInfoForm({
    super.key,
    required this.isEditing,
    required this.nomeController,
    required this.cpfController,
    required this.emailController,
    required this.telefoneController,
    required this.enderecoController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações Pessoais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              enabled: isEditing,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldCpf(cpfController: cpfController),
            const SizedBox(height: 16),
            TextFormFieldEmail(
              emailController: emailController,
              isEditing: isEditing,
            ),
            const SizedBox(height: 16),
            TextFormFieldPhone(
              telefoneController: telefoneController,
              isEditing: isEditing,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              enabled: isEditing,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
