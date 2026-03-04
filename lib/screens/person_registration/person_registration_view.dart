import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/person_registration/bloc/person_bloc.dart';
import 'package:system_loja/screens/person_registration/bloc/person_event.dart';
import 'package:system_loja/screens/person_registration/bloc/person_state.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';
import 'package:system_loja/screens/person_registration/widgets/person_registration_form.dart';
import 'package:system_loja/screens/utils/constants.dart';

/// Exibe a tela de cadastro unificado para pessoa física e jurídica.
///
/// Esta tela trata apenas entrada e validação dos dados.
/// Não executa persistência, busca ou consulta nesta etapa.
@RoutePage()
class PersonRegistrationView extends StatefulWidget {
  const PersonRegistrationView({super.key});

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
    return BlocListener<PersonBloc, PersonState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          ),
          success: () {
            Navigator.of(context).pop(); // Fecha o dialog de loading
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso!')));
            context.router.pop(); // Volta para a tela anterior
          },
          failure: (error) {
            Navigator.of(context).pop(); // Fecha o dialog de loading
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $error')));
          },
        );
      },
      child: Scaffold(
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

    context.read<PersonBloc>().add(PersonEvent.submit(formData));
  }
}
