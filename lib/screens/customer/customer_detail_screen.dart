import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/widgets/text_form_field_cpf.dart';
import 'package:system_loja/screens/widgets/text_form_field_email.dart';
import 'package:system_loja/screens/widgets/text_form_field_phone.dart';

/// Tela de detalhes do cliente com opções de edição e exclusão
///
/// Permite visualizar informações completas do cliente e realizar operações como:
/// - Editar dados do cliente
/// - Deletar cliente
/// - Consultar outro cliente pelo CPF
class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  late final TextEditingController _nomeController;
  late final TextEditingController _cpfController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _enderecoController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          customersLoaded: (customers) {
            // Cliente foi atualizado ou deletado com sucesso
            if (_isEditing) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente atualizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              setState(() {
                _isEditing = false;
              });
            } else {
              // Cliente foi deletado
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente deletado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          customerError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Cliente'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
                tooltip: 'Editar',
              ),
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: _confirmarExclusao,
                tooltip: 'Deletar',
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar e nome
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Text(
                      widget.customer.name.trim().isNotEmpty
                          ? widget.customer.name.trim()[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Informações do cliente
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informações Pessoais',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(
                            labelText: 'Nome *',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          enabled: _isEditing,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldCpf(cpfController: _cpfController),
                        const SizedBox(height: 16),
                        TextFormFieldEmail(
                          emailController: _emailController,
                          isEditing: _isEditing,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldPhone(
                          telefoneController: _telefoneController,
                          isEditing: _isEditing,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _enderecoController,
                          decoration: const InputDecoration(
                            labelText: 'Endereço',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.home),
                          ),
                          enabled: _isEditing,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Card com informações adicionais
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
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'ID',
                          widget.customer.id.toString(),
                          Icons.numbers,
                        ),
                        const Divider(),
                        _buildInfoRow(
                          'Data de Cadastro',
                          _formatDate(widget.customer.registrationDate),
                          Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Botões de ação quando em modo de edição
                if (_isEditing)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                              // Restaurar valores originais
                              _nomeController.text = widget.customer.name;
                              _emailController.text = widget.customer.email;
                              _telefoneController.text = widget.customer.phone;
                              _enderecoController.text =
                                  widget.customer.address;
                            });
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _salvarAlteracoes,
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
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.customer.name);
    _cpfController = TextEditingController(text: widget.customer.cpf);
    _emailController = TextEditingController(text: widget.customer.email);
    _telefoneController = TextEditingController(text: widget.customer.phone);
    _enderecoController = TextEditingController(text: widget.customer.address);
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o cliente "${widget.customer.name}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              context.read<CustomerBloc>().add(
                CustomerBlocEvent.deleteCustomer(id: widget.customer.id),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  /// Formata uma data no formato DD/MM/YYYY HH:MM
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      final updatedCustomer = Customer(
        id: widget.customer.id,
        name: _nomeController.text.trim(),
        cpf: _cpfController.text.trim(),
        email: _emailController.text.trim(),
        phone: _telefoneController.text.trim(),
        address: _enderecoController.text.trim(),
        registrationDate: widget.customer.registrationDate,
      );

      context.read<CustomerBloc>().add(
        CustomerBlocEvent.updateCustomer(customer: updatedCustomer),
      );
    }
  }
}
