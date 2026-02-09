import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

import '../../core/models/customer.dart';
import 'bloc/customer_bloc.dart';
import 'widgets/customer_form.dart';
import 'widgets/customer_list.dart';
import 'widgets/customer_search_section.dart';

@RoutePage()
class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

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
      child: Column(
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
                    streetController: _streetController,
                    zipCodeController: _zipCodeController,
                    neighborhoodController: _neighborhoodController,
                    cityController: _cityController,
                    stateController: _stateController,
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
    context.read<CustomerBloc>().add(const CustomerBlocEvent.loadCustomers());
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

    // Navega para a tela de detalhes do cliente
    context.router.root.push(CustomerDetailRoute(customer: customer));
  }
}
