import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/customer.dart';
import '../../core/utils/text_formatters.dart';
import 'bloc/customer_bloc.dart';
import 'customer_detail_screen.dart';

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
  int _previousCustomerCount = 0;
  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          customersLoaded: (customers) {
            // Show success message if we just added a customer
            if (_isAdding && customers.length > _previousCustomerCount) {
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
              _isAdding = false;
            }
            _previousCustomerCount = customers.length;
          },
          customerError: (message) {
            _isAdding = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
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
                child: Form(
                  key: _formKey,
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
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Adicionar mascaras e a validacao esta no bloc para CPF
                      TextFormField(
                        controller: _cpfController,
                        decoration: const InputDecoration(
                          labelText: 'CPF *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.badge),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [CpfTextInputFormatter()],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'CPF é obrigatório';
                          }
                          return null;
                        },
                        maxLength: 14, // Formato XXX.XXX.XXX-XX
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // Aqui você pode adicionar lógica para formatar o email enquanto o usuário digita
                          String formatted = value.trim();

                          _emailController.value = TextEditingValue(
                            text: formatted,
                            selection: TextSelection.collapsed(
                              offset: formatted.length,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [PhoneTextInputFormatter()],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _enderecoController,
                        decoration: const InputDecoration(
                          labelText: 'Endereço',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _adicionarCliente,
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar Cliente'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 32),
                      const Text(
                        'Buscar Cliente por CPF',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _searchCpfController,
                              decoration: const InputDecoration(
                                labelText: 'CPF',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Digite o CPF para buscar',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [CpfTextInputFormatter()],
                              maxLength: 14, // Formato XXX.XXX.XXX-XX
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _buscarClientePorCpf,
                            icon: const Icon(Icons.search),
                            label: const Text('Buscar'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 32),
                      const Text(
                        'Clientes Cadastrados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<CustomerBloc, CustomerBlocState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  'Carregando clientes...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            customersLoaded: (customers) {
                              if (customers.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: Text(
                                      'Nenhum cliente cadastrado',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: customers.length,
                                itemBuilder: (context, index) {
                                  final cliente = customers.values.elementAt(
                                    index,
                                  );
                                  return Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: ListTile(
                                      minLeadingWidth: 0,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      minVerticalPadding: 0,
                                      titleAlignment:
                                          ListTileTitleAlignment.center,

                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                          cliente.name[0].toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        cliente.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'CPF: ${cliente.cpf}\n${cliente.email}',
                                      ),
                                      isThreeLine: true,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                      onTap: () {
                                        _mostrarDetalhesCliente(cliente);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            customerError: (message) => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Text(
                                  'Erro: $message',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            customerFound: (customer) => const SizedBox.shrink(),
                          );
                        },
                      ),
                    ],
                  ),
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
      setState(() {
        _isAdding = true;
      });

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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _mostrarDetalhesCliente(Customer cliente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(cliente.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', cliente.id.toString()),
              _buildDetailRow('CPF', cliente.cpf),
              _buildDetailRow('Email', cliente.email),
              _buildDetailRow('Telefone', cliente.phone),
              _buildDetailRow('Endereço', cliente.address),
              _buildDetailRow(
                'Data de Cadastro',
                cliente.registrationDate.toString().split('.')[0],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _buscarClientePorCpf() {
    final cpf = _searchCpfController.text.trim();
    if (cpf.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um CPF para buscar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<CustomerBloc>().add(
          CustomerBlocEvent.findCustomerByCpf(cpf: cpf),
        );
  }

  void _openCustomerDetails(Customer customer) {
    // Limpa o campo de busca
    _searchCpfController.clear();
    
    // Navega para a tela de detalhes do cliente
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider.value(
          value: context.read<CustomerBloc>(),
          child: CustomerDetailScreen(customer: customer),
        ),
      ),
    );
  }
}
