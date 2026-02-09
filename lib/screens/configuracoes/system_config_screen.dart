import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_cubit.dart';

/// Widget para configurar as dados padrão do sistema
/// Cadastrar dados como tipos de pagamento, categorias de produtos, etc. para facilitar o uso do sistema.
@RoutePage()
class SystemConfigScreen extends StatefulWidget {
  const SystemConfigScreen({super.key});

  @override
  State<SystemConfigScreen> createState() => _SystemConfigScreenState();
}

class _SystemConfigScreenState extends State<SystemConfigScreen> {
  List<PaymentMethodType> selectedPaymentMethods = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações de Dados Padrão')),
      body: context.watch<SystemConfigCubit>().state.when(
        initial: () => const Center(child: Text('Carregando dados...')),
        loaded: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tipo de pagamento
            ListTile(
              title: const Text('Tipos de Pagamento'),
              subtitle: Text(data.priceConfiguration.types.join(', ')),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Lógica para editar os tipos de pagamento [PaymentMethodType]
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        children: [
                          Text('Selecione os tipos de pagamentos'),
                          ListView.builder(
                            itemCount: PaymentMethodType.values.length,
                            itemBuilder: (context, index) => CheckboxListTile(
                              title: Text(PaymentMethodType.values[index].name),
                              value: data.priceConfiguration.types.contains(
                                PaymentMethodType.values[index],
                              ),
                              onChanged: (value) {
                                if (value == true) {
                                  selectedPaymentMethods.add(
                                    PaymentMethodType.values[index],
                                  );
                                } else {
                                  selectedPaymentMethods.remove(
                                    PaymentMethodType.values[index],
                                  );
                                }
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context
                                  .read<SystemConfigCubit>()
                                  .saveConfigurationData(
                                    data.copyWith(
                                      priceConfiguration: PriceConfiguration(
                                        types: selectedPaymentMethods,
                                      ),
                                    ),
                                  );
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
