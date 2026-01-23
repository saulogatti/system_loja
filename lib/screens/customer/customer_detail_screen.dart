import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/customer/widgets/customer_action_buttons.dart';
import 'package:system_loja/screens/customer/widgets/customer_avatar.dart';
import 'package:system_loja/screens/customer/widgets/customer_info_form.dart';
import 'package:system_loja/screens/customer/widgets/customer_system_info_card.dart';

/// Tela de detalhes do cliente com opções de edição e exclusão
///
/// Permite visualizar informações completas do cliente e realizar operações como:
/// - Editar dados do cliente
/// - Deletar cliente
/// - Consultar outro cliente pelo CPF
@RoutePage()
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
 

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          customersLoaded: (customers, stateType) {
            if (stateType == EnumStateCustomerLoaded.updateCustomer) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente atualizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
       
            } else if (stateType == EnumStateCustomerLoaded.deleteCustomer) {
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomerAvatar(name: widget.customer.name),
              const SizedBox(height: 24),
              CustomerInfoForm(
                isEditing: true,
                nomeController: _nomeController,
                cpfController: _cpfController,
                emailController: _emailController,
                telefoneController: _telefoneController,
                enderecoController: _enderecoController,
              ),
              const SizedBox(height: 16),
              CustomerSystemInfoCard(
                customer: widget.customer,
                formatDate: _formatDate,
              ),
              const SizedBox(height: 24),
              CustomerActionButtons(
                onCancel: _cancelEditing,
                onSave: _salvarAlteracoes,
              ),
            ],
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

  void _cancelEditing() {
    setState(() {
      _nomeController.text = widget.customer.name;
      _emailController.text = widget.customer.email ?? '';
      _telefoneController.text = widget.customer.phone ?? '';
      _enderecoController.text = widget.customer.address ?? '';
    });
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
        lastUpdatedDate: widget.customer.lastUpdatedDate,
      );

      context.read<CustomerBloc>().add(
        CustomerBlocEvent.updateCustomer(customer: updatedCustomer),
      );
    }
  }
}
