import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/customer/bloc/customer_bloc.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Widget da lista de clientes cadastrados
///
/// Exibe os clientes em formato de lista com cards ou mensagem quando vazio.
/// Gerencia os estados do BLoC internamente.
class CustomerList extends StatelessWidget {
  /// Espaçamento padrão entre título e lista
  static const double _defaultSpacing = 16.0;

  final Function(Customer) onCustomerTap;

  const CustomerList({
    super.key,
    required this.onCustomerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Clientes Cadastrados',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: _defaultSpacing),
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
                    final cliente = customers.values.elementAt(index);
                    return CardListItem(
                      colorAvatar: Colors.blue,
                      title: cliente.name,
                      subTitle: 'CPF: ${cliente.cpf}\n${cliente.email}',
                      onTap: () => onCustomerTap(cliente),
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
    );
  }
}
