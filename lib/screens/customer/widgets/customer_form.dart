import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/utils/validators.dart';
import 'package:system_loja/screens/widgets/address_form.dart';
import 'package:system_loja/screens/widgets/text_form_field_cpf.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

/// Widget do formulário de cadastro e edição de cliente
///
/// Encapsula os campos de entrada e validações para criação e edição de clientes.
/// Quando em modo de edição, o campo CPF fica desabilitado.
@Deprecated.instantiate(
  'Use PersonRegistrationForm para um formulário unificado de pessoa física e jurídica',
)
class CustomerForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final VoidCallback onSubmit;
  final bool isEditMode;
  final VoidCallback? onCancel;

  const CustomerForm({
    required this.formKey,
    required this.nomeController,
    required this.cpfController,
    required this.emailController,
    required this.telefoneController,
    required this.streetController,
    required this.onSubmit,
    required this.zipCodeController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    super.key,
    this.isEditMode = false,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isEditMode ? 'Editar Cliente' : 'Novo Cliente',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            enable: !isEditMode, // CPF desabilitado em modo de edição
            validatorOptions: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'CPF é obrigatório';
              } else if (!value.isValidCpf()) {
                return 'CPF inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormFieldEmail(emailController: emailController, isEditing: true),
          const SizedBox(height: 16),
          TextFormFieldPhone(
            telefoneController: telefoneController,
            isEditing: true,
          ),
          const SizedBox(height: 16),
          AddressForm(
            streetController: streetController,
            zipCodeController: zipCodeController,
            neighborhoodController: neighborhoodController,
            cityController: cityController,
            stateController: stateController,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (isEditMode && onCancel != null) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancelar'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSubmit,
                  icon: Icon(isEditMode ? Icons.save : Icons.add),
                  label: Text(
                    isEditMode ? 'Salvar Alterações' : 'Adicionar Cliente',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
