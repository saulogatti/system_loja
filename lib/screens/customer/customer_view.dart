import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/customer.dart';
import 'bloc/customer_bloc.dart';
import 'customer_detail_screen.dart';
import 'widgets/customer_form.dart';
import 'widgets/customer_list.dart';
import 'widgets/customer_search_section.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerBloc()..add(const CustomerBlocEvent.loadCustomers()),
      child: const _CustomerDetailView(),
    );
  }
}

class _CustomerDetailView extends StatefulWidget {
  const _CustomerDetailView();

  @override
  State<_CustomerDetailView> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<_CustomerDetailView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _searchCpfController = TextEditingController();

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
                _enderecoController.clear();
              case EnumStateCustomerLoaded.deleteCustomer:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cliente deletado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              case EnumStateCustomerLoaded.customersLoaded:
              case EnumStateCustomerLoaded.updateCustomer:
            }
          },
          customerFound: (customer) {
            // Navega para a tela de detalhes quando um cliente é encontrado
            _openCustomerDetails(customer);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Cliente'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Formulário de cadastro
                    CustomerForm(
                      formKey: _formKey,
                      nomeController: _nomeController,
                      cpfController: _cpfController,
                      emailController: _emailController,
                      telefoneController: _telefoneController,
                      enderecoController: _enderecoController,
                      onSubmit: _adicionarCliente,
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
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _searchCpfController.dispose();
    super.dispose();
  }

  void _adicionarCliente() {
    if (_formKey.currentState!.validate()) {
      context.read<CustomerBloc>().add(
        CustomerBlocEvent.registerCustomer(
          name: _nomeController.text.trim(),
          cpf: _cpfController.text.trim(),
          email: _emailController.text.trim(),
          phone: _telefoneController.text.trim(),
          address: _enderecoController.text.trim(),
        ),
      );
    }
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

  /// Navega para a tela de detalhes do cliente
  ///
  /// Utilizado tanto para busca por CPF quanto para seleção da lista.
  void _mostrarDetalhesCliente(Customer cliente) {
    _openCustomerDetails(cliente);
  }

  void _openCustomerDetails(Customer customer) {
    // Limpa o campo de busca
    _searchCpfController.clear();
    final bloc = context.read<CustomerBloc>();
    // Navega para a tela de detalhes do cliente
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: CustomerDetailScreen(customer: customer),
        ),
      ),
    );
  }
}
