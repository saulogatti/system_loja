import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Widget da lista de clientes cadastrados
///
/// Exibe os clientes em formato de lista com cards ou mensagem quando vazio.
/// Gerencia os estados do BLoC internamente.
class CustomerList extends StatefulWidget {
  /// Espaçamento padrão entre título e lista
  static const double _defaultSpacing = 16.0;

  final Function(Customer) onCustomerTap;

  const CustomerList({super.key, required this.onCustomerTap});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final Map<int, Customer> _customers = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Clientes Cadastrados',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: CustomerList._defaultSpacing),
        BlocListener<CustomerBloc, CustomerBlocState>(
          listener: (context, state) {
            state.when(
              initial: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'Carregando clientes...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              customersLoaded: (customers, stateType) {
                _customers.clear();
                _customers.addAll(customers);
                setState(() {});
              },

              customerError: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,

                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },

              customerFound: (customer) => const SizedBox.shrink(),
            );
          },
          child: Column(
            children: [
              if (_customers.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'Nenhum cliente cadastrado',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              if (_customers.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: _customers.length,
                  itemBuilder: (context, index) {
                    final cliente = _customers.values.elementAt(index);
                    return CardListItem(
                      colorAvatar: Colors.blue,
                      title: cliente.name,
                      subTitle: 'CPF: ${cliente.cpf}\n${cliente.email}',
                      onTap: () => widget.onCustomerTap(cliente),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
