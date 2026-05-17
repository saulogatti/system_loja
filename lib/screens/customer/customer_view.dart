import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';
import 'package:system_loja/screens/person_registration/widgets/person_registration_form.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

import '../../core/models/address.dart';
import '../../core/models/customer.dart';
import 'bloc/customer_bloc.dart';
import 'widgets/customer_form.dart';
import 'widgets/customer_list.dart';
import 'widgets/customer_overview_bottom_sheet.dart';
import 'widgets/customer_search_section.dart';

@RoutePage()
class CustomerView extends StatefulWidget {
  /// Cliente opcional para modo de edição
  /// Se fornecido, o formulário será preenchido com os dados do cliente para edição
  final Customer? customer;

  const CustomerView({super.key, this.customer});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _searchCpfController = TextEditingController();

  /// Indica se está em modo de edição
  bool get _isEditMode => widget.customer != null;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          customersLoaded: (customers, stateType) {
            switch (stateType) {
              case EnumStateCustomerLoaded.registerCustomer:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cliente cadastrado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
                _formKey.currentState!.reset();
                _nomeController.clear();
                _cpfController.clear();
                _emailController.clear();
                _telefoneController.clear();
                _streetController.clear();
                _zipCodeController.clear();
                _neighborhoodController.clear();
                _cityController.clear();
              case EnumStateCustomerLoaded.updateCustomer:
                if (_isEditMode) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cliente atualizado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Volta para a tela anterior após atualizar
                  if (widget.customer != null) {
                    AutoRouter.of(context).pop();
                  }
                }
              case EnumStateCustomerLoaded.deleteCustomer:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cliente deletado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              case EnumStateCustomerLoaded.customersLoaded:
            }
          },
          customerFound: (customer) {
            // Navega para a tela de detalhes quando um cliente é encontrado
            _openCustomerDetails(customer);
          },
        );
      },
      child: _isEditMode ? _buildEditView(context) : _buildAddView(context),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _streetController.dispose();
    _zipCodeController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _searchCpfController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Se está em modo de edição, preenche os campos com os dados do cliente
    if (_isEditMode) {
      _nomeController.text = widget.customer!.name;
      _cpfController.text = widget.customer!.cpf;
      _emailController.text = widget.customer!.email ?? '';
      _telefoneController.text = widget.customer!.phone ?? '';
      _streetController.text = widget.customer!.address.street;
      _zipCodeController.text = widget.customer!.address.zipCode;
      _neighborhoodController.text = widget.customer!.address.neighborhood;
      _cityController.text = widget.customer!.address.city;
      _stateController.text = widget.customer!.address.state;
    } else {
      // Se não está em modo de edição, carrega a lista de clientes
      context.read<CustomerBloc>().add(const CustomerBlocEvent.loadCustomers());
    }
  }

  void _adicionarCliente() {
    if (_formKey.currentState!.validate()) {
      context.read<CustomerBloc>().add(
        CustomerBlocEvent.registerCustomer(
          name: _nomeController.text.trim(),
          cpf: _cpfController.text.trim(),
          email: _emailController.text.trim(),
          phone: _telefoneController.text.trim(),
          street: _streetController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
          neighborhood: _neighborhoodController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
        ),
      );
    }
  }

  /// Constrói a view de adição de cliente com lista e busca
  Widget _buildAddView(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Formulário de cadastro
                   PersonRegistrationForm(
                    formKey: _formKey,
                    nameController: _nomeController,
                    documentController: _cpfController,
                    emailController: _emailController,
                    phoneController: _telefoneController,
                    streetController: _streetController,
                    zipCodeController: _zipCodeController,
                    neighborhoodController: _neighborhoodController,
                    cityController: _cityController,
                    stateController: _stateController,
                    onSubmit: _adicionarCliente,
                    selectedPersonType: PersonType.individual,
                     onPersonTypeChanged: (personType) {  
                        // Não permite mudar o tipo de pessoa no cadastro de cliente
                        // Apenas mantém como individual
                      },
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  // Seção de busca por CPF
                  CustomerSearchSection(
                    searchCpfController: _searchCpfController,
                    onSearch: _buscarClientePorCpf,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  // Lista de clientes
                  CustomerList(onCustomerTap: _mostrarDetalhesCliente),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói a view de edição de cliente
  Widget _buildEditView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente: ${widget.customer!.name}'),
        leading: AutoLeadingButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PersonRegistrationForm(
              formKey: _formKey,
              nameController: _nomeController,
              documentController: _cpfController,
              emailController: _emailController,
              phoneController: _telefoneController,
              streetController: _streetController,
              zipCodeController: _zipCodeController,
              neighborhoodController: _neighborhoodController,
              cityController: _cityController,
              stateController: _stateController,
              onSubmit: _salvarAlteracoes,
              selectedPersonType: PersonType.individual,
              onPersonTypeChanged: _cancelarEdicao,
            ),
            const SizedBox(height: 24),
            // Card com informações do sistema
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informações do Sistema',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('ID', widget.customer!.id.toString()),
                    _buildInfoRow(
                      'Data de Cadastro',
                      widget.customer!.registrationDate.toFormattedDate(),
                    ),
                    _buildInfoRow(
                      'Última Atualização',
                      widget.customer!.lastUpdatedDate.toFormattedDate(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  void _buscarClientePorCpf() {
    final cpf = _searchCpfController.text.trim();
    if (cpf.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Digite um CPF para buscar'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    context.read<CustomerBloc>().add(
      CustomerBlocEvent.findCustomerByCpf(cpf: cpf),
    );
  }

  void _cancelarEdicao(PersonType? personType) {
    // Restaura os valores originais do cliente
    if (_isEditMode) {
      AutoRouter.of(context).pop();
    }
  }

  /// Navega para a tela de detalhes do cliente
  ///
  /// Utilizado tanto para busca por CPF quanto para seleção da lista.
  void _mostrarDetalhesCliente(Customer cliente) {
    _openCustomerDetails(cliente);
  }

  void _openCustomerDetails(Customer customer) {
    // Limpa o campo de busca
    _searchCpfController.clear();

    // Exibe o bottom sheet de visão geral do cliente
    CustomerOverviewBottomSheet.show(context, customer);
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      final updatedCustomer = Customer(
        id: widget.customer!.id,
        name: _nomeController.text.trim(),
        cpf: _cpfController.text.trim(),
        email: _emailController.text.trim(),
        phone: _telefoneController.text.trim(),
        address: Address(
          street: _streetController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
          neighborhood: _neighborhoodController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
        ),
        registrationDate: widget.customer!.registrationDate,
        lastUpdatedDate: widget.customer!.lastUpdatedDate,
      );

      context.read<CustomerBloc>().add(
        CustomerBlocEvent.updateCustomer(customer: updatedCustomer),
      );
    }
  }
}
