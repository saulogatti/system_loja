import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';
import 'package:system_loja/screens/person_registration/widgets/person_registration_form.dart';
import 'package:system_loja/screens/utils/constants.dart';

/// Assinatura de callback para receber os dados validados do formulário.
typedef OnPersonRegistrationValidated = void Function(PersonRegistrationFormData formData);

/// Exibe a tela de cadastro unificado para pessoa física e jurídica.
///
/// Esta tela trata apenas entrada e validação dos dados.
/// Não executa persistência, busca ou consulta nesta etapa.
@RoutePage()
class PersonRegistrationView extends StatefulWidget {
  /// Recebe os dados já validados para integração futura com regra de negócio.
  final OnPersonRegistrationValidated? onValidated;

  const PersonRegistrationView({super.key, this.onValidated});

  @override
  State<PersonRegistrationView> createState() => _PersonRegistrationViewState();
}

class _PersonRegistrationViewState extends State<PersonRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _documentController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  PersonType _selectedPersonType = PersonType.individual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pessoa'), leading: const AutoLeadingButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: PersonRegistrationForm(
          formKey: _formKey,
          selectedPersonType: _selectedPersonType,
          onPersonTypeChanged: _onPersonTypeChanged,
          nameController: _nameController,
          documentController: _documentController,
          emailController: _emailController,
          phoneController: _phoneController,
          streetController: _streetController,
          zipCodeController: _zipCodeController,
          neighborhoodController: _neighborhoodController,
          cityController: _cityController,
          stateController: _stateController,
          onSubmit: _validateAndEmit,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _documentController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _zipCodeController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  /// Processa a troca do tipo de pessoa e limpa o documento atual.
  void _onPersonTypeChanged(PersonType? selectedType) {
    if (selectedType == null || selectedType == _selectedPersonType) {
      return;
    }

    setState(() {
      _selectedPersonType = selectedType;
      _documentController.clear();
    });
  }

  /// Valida o formulário e emite os dados tratados sem máscara no documento.
  void _validateAndEmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final formData = PersonRegistrationFormData(
      personType: _selectedPersonType,
      name: _nameController.text.trim(),
      document: _documentController.text.replaceAll(Constants.nonNumericRegExp, ''),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      street: _streetController.text.trim(),
      zipCode: _zipCodeController.text.trim(),
      neighborhood: _neighborhoodController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
    );

    widget.onValidated?.call(formData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados validados com sucesso!'), backgroundColor: Colors.green),
    );
  }
}
