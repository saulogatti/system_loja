import 'package:flutter/material.dart';

import '../core/managers/cliente_manager.dart';
import '../core/models/cliente.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final ClienteManager _manager = ClienteManager();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Text('Novo Cliente', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                    TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'CPF é obrigatório';
                        }
                        return null;
                      },
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
                    const Text(
                      'Clientes Cadastrados',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (_manager.clientes.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'Nenhum cliente cadastrado',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _manager.clientes.length,
                        itemBuilder: (context, index) {
                          final cliente = _manager.clientes[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  cliente.nome[0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(cliente.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('CPF: ${cliente.cpf}\n${cliente.email}'),
                              isThreeLine: true,
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                _mostrarDetalhesCliente(cliente);
                              },
                            ),
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
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  void _adicionarCliente() async {
    if (_formKey.currentState!.validate()) {
      final cpf = _cpfController.text.trim();

      // Check if CPF already exists
      if (_manager.clientes.any((c) => c.cpf == cpf)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: CPF já cadastrado!'), backgroundColor: Colors.red),
        );
        return;
      }

      final cliente = Cliente(
        id: _manager.clientes.isEmpty
            ? 1
            : _manager.clientes.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1,
        nome: _nomeController.text.trim(),
        cpf: cpf,
        email: _emailController.text.trim(),
        telefone: _telefoneController.text.trim(),
        endereco: _enderecoController.text.trim(),
      );

      _manager.clientes.add(cliente);
      await _manager.salvarDadosSincronizado();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cliente "${cliente.nome}" cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      _formKey.currentState!.reset();
      _nomeController.clear();
      _cpfController.clear();
      _emailController.clear();
      _telefoneController.clear();
      _enderecoController.clear();
      setState(() {});
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
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _mostrarDetalhesCliente(Cliente cliente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(cliente.nome),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', cliente.id.toString()),
              _buildDetailRow('CPF', cliente.cpf),
              _buildDetailRow('Email', cliente.email),
              _buildDetailRow('Telefone', cliente.telefone),
              _buildDetailRow('Endereço', cliente.endereco),
              _buildDetailRow('Data de Cadastro', cliente.dataCadastro.toString().split('.')[0]),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
      ),
    );
  }
}
