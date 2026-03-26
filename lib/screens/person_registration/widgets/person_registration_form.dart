import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_loja/screens/utils/text_formatters.dart';
import 'package:system_loja/screens/utils/validators.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';
import 'package:system_loja/screens/widgets/address_form.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

/// Renderiza o formulário dinâmico para cadastro de pessoa física ou jurídica.
class PersonRegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PersonType selectedPersonType;
  final ValueChanged<PersonType?> onPersonTypeChanged;
  final TextEditingController nameController;
  final TextEditingController documentController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final VoidCallback onSubmit;

  const PersonRegistrationForm({
    required this.formKey,
    required this.selectedPersonType,
    required this.onPersonTypeChanged,
    required this.nameController,
    required this.documentController,
    required this.emailController,
    required this.phoneController,
    required this.streetController,
    required this.zipCodeController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isIndividual = selectedPersonType == PersonType.individual;
    final documentLabel = selectedPersonType.documentLabel;

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Cadastro de Pessoa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SegmentedButton<PersonType>(
            segments: PersonType.values
                .map(
                  (type) => ButtonSegment<PersonType>(
                    value: type,
                    label: Text(type.displayName),
                    icon: Icon(type == PersonType.individual ? Icons.person : Icons.business),
                  ),
                )
                .toList(),
            selected: {selectedPersonType},
            onSelectionChanged: (selection) {
              onPersonTypeChanged(selection.isEmpty ? null : selection.first);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: '${selectedPersonType.nameLabel} *'),
            validator: (value) => combineValidators([
              (v) => validateRequired(v, selectedPersonType.nameLabel),
              (v) => validateMinLength(v, 3, selectedPersonType.nameLabel),
            ])(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: ValueKey<PersonType>(selectedPersonType),
            controller: documentController,
            decoration: InputDecoration(
              labelText: '$documentLabel *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.badge),
              hintText: isIndividual ? '000.000.000-00' : '00.000.000/0000-00',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: _documentInputFormatters(selectedPersonType),
            validator: (value) => selectedPersonType.validateDocument(value: value),
          ),
          const SizedBox(height: 16),
          TextFormFieldEmail(emailController: emailController, isEditing: true),
          const SizedBox(height: 16),
          TextFormFieldPhone(telefoneController: phoneController, isEditing: true),
          const SizedBox(height: 16),
          AddressForm(
            streetController: streetController,
            zipCodeController: zipCodeController,
            neighborhoodController: neighborhoodController,
            cityController: cityController,
            stateController: stateController,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Validar Dados'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  /// Retorna os formatadores de entrada do documento por tipo de pessoa.
  List<TextInputFormatter> _documentInputFormatters(PersonType personType) {
    if (personType == PersonType.individual) {
      return [CpfTextInputFormatter()];
    }

    return [CnpjTextInputFormatter()];
  }
}
