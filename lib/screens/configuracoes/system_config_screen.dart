import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/app_injection.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';

/// Widget para configurar as dados padrão do sistema
/// Cadastrar dados como tipos de pagamento, categorias de produtos, etc. para facilitar o uso do sistema.
@RoutePage()
class SystemConfigScreen extends StatefulWidget implements AutoRouteWrapper {
  const SystemConfigScreen({super.key});

  @override
  State<SystemConfigScreen> createState() => _SystemConfigScreenState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SystemConfigCubit>(
      create: (_) => SystemConfigCubit(appInjection.get<ISystemRepository>()),
      child: this,
    );
  }
}

class _SystemConfigScreenState extends State<SystemConfigScreen> {
  List<PaymentMethodType> selectedPaymentMethods = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações de Dados Padrão'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<SystemConfigCubit>().saveConfigurationData(
                paymentMethods: selectedPaymentMethods,
              );
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
      body: BlocConsumer<SystemConfigCubit, SystemConfigState>(
        listener: (context, state) {
          if (state is SystemConfigStateLoaded) {
            selectedPaymentMethods = List.from(
              state.data.priceConfiguration.types,
              growable: true,
            );
            setState(() {});
          } else if (state is SystemConfigStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case SystemConfigStateLoading():
              return const Center(child: CircularProgressIndicator());
            case SystemConfigStateError():
              return Center(child: Text(state.message));
            case SystemConfigStateLoaded():
              return Column(
                children: [
                  Text('Selecione os tipos de pagamentos'),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: PaymentMethodType.values.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: selectedPaymentMethods.contains(
                            PaymentMethodType.values[index],
                          ),
                          title: Text(PaymentMethodType.values[index].name),
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
                            setState(() {
                              // como alteramos a lista antes, seja tirar ou adicionar um item, o setState() é necessário para atualizar a tela. Podemos colocar um listener para atualizar o componente apenas. O que acha ? Não precisa de listener, pois o setState() é suficiente. Ok, obrigado.
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            case SystemConfigStateInitial():
              return const Center(child: Text('Carregando dados...'));
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<SystemConfigCubit>().loadConfigurationData();
  }
}
