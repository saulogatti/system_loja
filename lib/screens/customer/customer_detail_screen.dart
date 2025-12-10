import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/widgets/loading_overlay.dart';
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

enum _CustomerAction { update, delete }

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  late final TextEditingController _nomeController;
  late final TextEditingController _cpfController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _enderecoController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  _CustomerAction? _pendingAction;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.customer.name);
    _cpfController = TextEditingController(text: widget.customer.cpf);
    _emailController = TextEditingController(text: widget.customer.email);
    _telefoneController = TextEditingController(text: widget.customer.phone);
    _enderecoController = TextEditingController(text: widget.customer.address);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          customersLoaded: (customers) {
            if (_pendingAction == _CustomerAction.update) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente atualizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              setState(() {
                _isEditing = false;
              });
            } else if (_pendingAction == _CustomerAction.delete) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente deletado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
            _pendingAction = null;
          },
          customerError: (message) {
            _pendingAction = null;
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
                onPressed: _habilitarEdicao,
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
        body: BlocBuilder<CustomerBloc, CustomerBlocState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            final loadingMessage = _pendingAction == _CustomerAction.update
                ? 'Salvando cliente...'
                : _pendingAction == _CustomerAction.delete
                    ? 'Deletando cliente...'
                    : 'Carregando dados...';

            return Stack(
              children: [
                _CustomerDetailContent(
                  customer: widget.customer,
                  isEditing: _isEditing,
                  formKey: _formKey,
                  nomeController: _nomeController,
                  cpfController: _cpfController,
                  emailController: _emailController,
                  telefoneController: _telefoneController,
                  enderecoController: _enderecoController,
                  cpfValidator: _validateCpf,
                  emailValidator: _validateEmail,
                  phoneValidator: _validatePhone,
                  onCancelEditing: _cancelarEdicao,
                  onSaveChanges: _salvarAlteracoes,
                ),
                if (isLoading) LoadingOverlay(message: loadingMessage),
              ],
            );
          },
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

  void _habilitarEdicao() {
    setState(() {
      _isEditing = true;
    });
  }

  void _cancelarEdicao() {
    setState(() {
      _isEditing = false;
      _nomeController.text = widget.customer.name;
      _emailController.text = widget.customer.email;
      _telefoneController.text = widget.customer.phone;
      _enderecoController.text = widget.customer.address;
    });
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
              _pendingAction = _CustomerAction.delete;
              Navigator.pop(context);
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

  String? _validateCpf(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'CPF é obrigatório';
    }
    if (!trimmed.isValidCPF()) {
      return 'CPF inválido';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    if (!trimmed.isValidEmail()) {
      return 'Email inválido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    if (!trimmed.isValidPhone()) {
      return 'Telefone inválido';
    }
    return null;
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      _pendingAction = _CustomerAction.update;
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

/// Conteúdo principal da tela de detalhes do cliente.
class _CustomerDetailContent extends StatelessWidget {
  const _CustomerDetailContent({
    required this.customer,
    required this.isEditing,
    required this.formKey,
    required this.nomeController,
    required this.cpfController,
    required this.emailController,
    required this.telefoneController,
    required this.enderecoController,
    required this.cpfValidator,
    required this.emailValidator,
    required this.phoneValidator,
    required this.onCancelEditing,
    required this.onSaveChanges,
  });

  final Customer customer;
  final bool isEditing;
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController enderecoController;
  final String? Function(String?) cpfValidator;
  final String? Function(String?) emailValidator;
  final String? Function(String?) phoneValidator;
  final VoidCallback onCancelEditing;
  final VoidCallback onSaveChanges;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CustomerAvatar(name: customer.name),
            const SizedBox(height: 24),
            _CustomerInfoCard(
              isEditing: isEditing,
              nomeController: nomeController,
              cpfController: cpfController,
              emailController: emailController,
              telefoneController: telefoneController,
              enderecoController: enderecoController,
              cpfValidator: cpfValidator,
              emailValidator: emailValidator,
              phoneValidator: phoneValidator,
            ),
            const SizedBox(height: 16),
            _SystemInfoCard(
              customer: customer,
            ),
            const SizedBox(height: 24),
            _EditActions(
              isEditing: isEditing,
              onCancelEditing: onCancelEditing,
              onSaveChanges: onSaveChanges,
            ),
          ],
        ),
      ),
    );
  }
}

/// Avatar do cliente com inicial.
class _CustomerAvatar extends StatelessWidget {
  const _CustomerAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        child: Text(
          name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Card com informações pessoais e formulário de edição.
class _CustomerInfoCard extends StatelessWidget {
  const _CustomerInfoCard({
    required this.isEditing,
    required this.nomeController,
    required this.cpfController,
    required this.emailController,
    required this.telefoneController,
    required this.enderecoController,
    required this.cpfValidator,
    required this.emailValidator,
    required this.phoneValidator,
  });

  final bool isEditing;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController enderecoController;
  final String? Function(String?) cpfValidator;
  final String? Function(String?) emailValidator;
  final String? Function(String?) phoneValidator;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              enabled: isEditing,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldCpf(
              cpfController: cpfController,
              validatorOptions: cpfValidator,
            ),
            const SizedBox(height: 16),
            TextFormFieldEmail(
              emailController: emailController,
              isEditing: isEditing,
              validator: emailValidator,
            ),
            const SizedBox(height: 16),
            TextFormFieldPhone(
              telefoneController: telefoneController,
              isEditing: isEditing,
              validator: phoneValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              enabled: isEditing,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

/// Card com informações do sistema (ID e datas).
class _SystemInfoCard extends StatelessWidget {
  const _SystemInfoCard({required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            _InfoRow(
              label: 'ID',
              value: customer.id.toString(),
              icon: Icons.numbers,
            ),
            const Divider(),
            _InfoRow(
              label: 'Data de Cadastro',
              value: _formatDate(customer.registrationDate),
              icon: Icons.calendar_today,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }
}

/// Ações de edição apresentadas ao usuário.
class _EditActions extends StatelessWidget {
  const _EditActions({
    required this.isEditing,
    required this.onCancelEditing,
    required this.onSaveChanges,
  });

  final bool isEditing;
  final VoidCallback onCancelEditing;
  final VoidCallback onSaveChanges;

  @override
  Widget build(BuildContext context) {
    if (!isEditing) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancelEditing,
            child: const Text('Cancelar'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onSaveChanges,
            child: const Text('Salvar Alterações'),
          ),
        ),
      ],
    );
  }
}

/// Linha de informação com ícone e rótulo.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
}
