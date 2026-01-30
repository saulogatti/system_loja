import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';

/// Widget do formulário de cadastro de empresa
///
/// Encapsula os campos de entrada e validações para criação de novas empresas.
class CompanyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController corporateNameController;
  final TextEditingController cnpjController;
  final TextEditingController emailController;
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final VoidCallback onSubmit;

  const CompanyForm({
    super.key,
    required this.formKey,
    required this.corporateNameController,
    required this.cnpjController,
    required this.emailController,
    required this.streetController,
    required this.zipCodeController,
    required this.neighborhoodController,
    required this.cityController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Nova Empresa',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: corporateNameController,
            decoration: const InputDecoration(
              labelText: 'Razão Social *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.business),
            ),
            validator: (value) => combineValidators([
              (v) => validateRequired(v, 'Razão Social'),
              (v) => validateMinLength(v, 3, 'Razão Social'),
            ])(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: cnpjController,
            decoration: const InputDecoration(
              labelText: 'CNPJ *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge),
              hintText: '00.000.000/0000-00',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'CNPJ é obrigatório';
              }
              // Remove caracteres não numéricos para validação
              final cnpjNumeros = value.replaceAll(RegExp(r'[^0-9]'), '');
              if (cnpjNumeros.length != 14) {
                return 'CNPJ deve conter 14 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormFieldEmail(emailController: emailController, isEditing: true),
          const SizedBox(height: 16),
          Text(
            'Endereço',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: streetController,
            decoration: const InputDecoration(
              labelText: 'Rua',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.markunread_mailbox),
                    hintText: '00000-000',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: neighborhoodController,
                  decoration: const InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'Cidade',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_city),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Empresa'),
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
