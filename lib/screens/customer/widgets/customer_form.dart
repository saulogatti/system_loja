import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/widgets/text_form_field_cpf.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

/// Widget do formulário de cadastro de cliente
///
/// Encapsula os campos de entrada e validações para criação de novos clientes.
class CustomerForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController enderecoController;
  final VoidCallback onSubmit;

  const CustomerForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.cpfController,
    required this.emailController,
    required this.telefoneController,
    required this.enderecoController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Novo Cliente',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) => combineValidators([
              (v) => validateRequired(v, 'Nome'),
              (v) => validateMinLength(v, 3, 'Nome'),
            ])(value),
          ),
          const SizedBox(height: 16),
          TextFormFieldCpf(
            cpfController: cpfController,
            enable: true,
            validatorOptions: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'CPF é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormFieldEmail(
            emailController: emailController,
            isEditing: true,
          ),
          const SizedBox(height: 16),
          TextFormFieldPhone(
            telefoneController: telefoneController,
            isEditing: true,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: enderecoController,
            decoration: const InputDecoration(
              labelText: 'Endereço',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.home),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Cliente'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
