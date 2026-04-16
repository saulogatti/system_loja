import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/person_registration/cubit/customer_edit_cubit.dart';
import 'package:system_loja/screens/person_registration/cubit/customer_edit_state.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';
import 'package:system_loja/screens/utils/validators.dart';
import 'package:system_loja/screens/widgets/address_form.dart';
import 'package:system_loja/screens/widgets/text_form_field_cpf.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

@RoutePage()
class CustomerEditView extends StatefulWidget implements AutoRouteWrapper {
  final Customer customer;

  const CustomerEditView({required this.customer, super.key});

  @override
  State<CustomerEditView> createState() => _CustomerEditViewState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerEditCubit(appInjection.get<ICustomerRepository>()),
      child: this,
    );
  }
}

class _CustomerEditViewState extends State<CustomerEditView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _cpfController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _streetController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;

  bool _isLoadingDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerEditCubit, CustomerEditState>(
      listener: _onStateChanged,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Pessoa Física'),
          leading: const AutoLeadingButton(),
          actions: [
            IconButton(
              tooltip: 'Excluir',
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => combineValidators([
                    (v) => validateRequired(v, 'Nome Completo'),
                    (v) => validateMinLength(v, 3, 'Nome Completo'),
                  ])(value),
                ),
                const SizedBox(height: 16),
                TextFormFieldCpf(cpfController: _cpfController, enable: false),
                const SizedBox(height: 16),
                TextFormFieldEmail(
                  emailController: _emailController,
                  isEditing: true,
                ),
                const SizedBox(height: 16),
                TextFormFieldPhone(
                  telefoneController: _phoneController,
                  isEditing: true,
                ),
                const SizedBox(height: 16),
                AddressForm(
                  streetController: _streetController,
                  zipCodeController: _zipCodeController,
                  neighborhoodController: _neighborhoodController,
                  cityController: _cityController,
                  stateController: _stateController,
                ),
                const SizedBox(height: 16),
                _buildReadOnlyDateField(
                  label: 'Data de Cadastro',
                  value: widget.customer.registrationDate.toFormattedDate(),
                ),
                const SizedBox(height: 16),
                _buildReadOnlyDateField(
                  label: 'Última Atualização',
                  value: widget.customer.lastUpdatedDate.toFormattedDate(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.router.maybePop(false),
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        child: const Text('Salvar Alterações'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _zipCodeController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final customer = widget.customer;
    _nameController = TextEditingController(text: customer.name);
    _cpfController = TextEditingController(text: customer.cpf);
    _emailController = TextEditingController(text: customer.email ?? '');
    _phoneController = TextEditingController(text: customer.phone ?? '');
    _streetController = TextEditingController(text: customer.address.street);
    _zipCodeController = TextEditingController(text: customer.address.zipCode);
    _neighborhoodController = TextEditingController(
      text: customer.address.neighborhood,
    );
    _cityController = TextEditingController(text: customer.address.city);
    _stateController = TextEditingController(text: customer.address.state);
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir pessoa física'),
          content: Text('Deseja realmente excluir "${widget.customer.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    if (shouldDelete == true) {
      context.read<CustomerEditCubit>().deleteCustomer(widget.customer.id);
    }
  }

  void _hideLoadingIfNeeded() {
    if (!_isLoadingDialogOpen) {
      return;
    }
    Navigator.of(context, rootNavigator: true).pop();
    _isLoadingDialogOpen = false;
  }

  String? _nullableTrim(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  void _onStateChanged(BuildContext context, CustomerEditState state) {
    if (state is CustomerEditLoading) {
      _showLoading();
      return;
    }

    _hideLoadingIfNeeded();

    if (state is CustomerEditSaved) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
      context.router.maybePop(true);
      return;
    }

    if (state is CustomerEditDeleted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
      context.router.maybePop(true);
      return;
    }

    if (state is CustomerEditError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updated = Customer(
      id: widget.customer.id,
      name: _nameController.text.trim(),
      cpf: widget.customer.cpf,
      email: _nullableTrim(_emailController.text),
      phone: _nullableTrim(_phoneController.text),
      address: Address(
        street: _streetController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
        neighborhood: _neighborhoodController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
      ),
      registrationDate: widget.customer.registrationDate,
      lastUpdatedDate: DateTime.now(),
    );

    context.read<CustomerEditCubit>().updateCustomer(updated);
  }

  void _showLoading() {
    if (_isLoadingDialogOpen) {
      return;
    }
    _isLoadingDialogOpen = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildReadOnlyDateField({
    required String label,
    required String value,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.event_note),
      ),
      readOnly: true,
      enabled: false,
    );
  }
}
