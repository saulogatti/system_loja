import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Tela para configurar dados padrão e parâmetros técnicos do sistema.
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
  final TextEditingController _measurementUnitController =
      TextEditingController();
  final TextEditingController _defaultPeriodController = TextEditingController(
    text: '30',
  );

  List<PaymentMethodType> _selectedPaymentMethods = [];
  List<String> _measurementUnits = [];
  bool _enableSalesByPeriod = true;
  bool _enableTopProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações de Dados Padrão')),
      body: BlocConsumer<SystemConfigCubit, SystemConfigState>(
        listener: (context, state) {
          if (state is SystemConfigStateLoaded) {
            _applyLoadedData(state.data);
            if (state.feedbackMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.feedbackMessage!),
                  backgroundColor: Colors.green,
                ),
              );
            }
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
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    _buildPaymentMethodsSection(),
                    _buildMeasurementUnitsSection(),
                    _buildCategoriesSection(context),
                    _buildReportsSection(),
                    _buildActions(context),
                  ],
                ),
              );
            case SystemConfigStateInitial():
              return const Center(child: Text('Carregando dados...'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _measurementUnitController.dispose();
    _defaultPeriodController.dispose();
    super.dispose();
  }

  void _addMeasurementUnit() {
    final rawUnit = _measurementUnitController.text.trim().toUpperCase();
    if (rawUnit.isEmpty) {
      return;
    }

    if (_measurementUnits.any((unit) => unit.toUpperCase() == rawUnit)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unidade de medida já adicionada.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _measurementUnits.add(rawUnit);
      _measurementUnitController.clear();
      _measurementUnits.sort();
    });
  }

  void _applyLoadedData(SystemConfiguration data) {
    _selectedPaymentMethods = List<PaymentMethodType>.from(
      data.priceConfiguration.types,
      growable: true,
    );
    _measurementUnits = List<String>.from(
      data.priceConfiguration.measurementUnits,
      growable: true,
    );

    final reportConfiguration = data.priceConfiguration.reportConfiguration;
    _enableSalesByPeriod = reportConfiguration?.enableSalesByPeriod ?? false;
    _enableTopProducts = reportConfiguration?.enableTopProducts ?? false;
    _defaultPeriodController.text =
        reportConfiguration?.defaultPeriodInDays.toString() ?? '0';
  }

  Widget _buildActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => _saveConfiguration(context),
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            ),
            OutlinedButton.icon(
              onPressed: () => _resetConfiguration(
                context,
                context.read<SystemConfigCubit>(),
              ),
              icon: const Icon(Icons.restore),
              label: const Text('Restaurar padrão'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                context.read<SystemConfigCubit>().exportConfiguration();
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Exportar'),
            ),
            OutlinedButton.icon(
              onPressed: () => _importConfiguration(
                context,
                context.read<SystemConfigCubit>(),
              ),
              icon: const Icon(Icons.download),
              label: const Text('Importar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Categorias de produtos'),
        subtitle: const Text(
          'O cadastro de categorias é centralizado e pode ser gerenciado em uma tela dedicada.',
        ),
        trailing: FilledButton.tonal(
          onPressed: () {
            context.router.push(const CategoryManagementRoute());
          },
          child: const Text('Gerenciar'),
        ),
      ),
    );
  }

  Widget _buildMeasurementUnitsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Unidades de medida padrão'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _measurementUnitController,
                    decoration: const InputDecoration(
                      hintText: 'Ex.: UN, KG, CX',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addMeasurementUnit,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_measurementUnits.isEmpty)
              const Text(
                'Nenhuma unidade adicionada.',
                style: TextStyle(color: Colors.grey),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _measurementUnits
                    .map(
                      (unit) => InputChip(
                        label: Text(unit),
                        onDeleted: () {
                          setState(() {
                            _measurementUnits.remove(unit);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tipos de pagamento padrão'),
            const SizedBox(height: 8),
            ...PaymentMethodType.values.map(
              (paymentMethod) => CheckboxListTile(
                value: _selectedPaymentMethods.contains(paymentMethod),
                title: Text(paymentMethod.name),
                contentPadding: EdgeInsets.zero,
                onChanged: (isSelected) {
                  setState(() {
                    if (isSelected == true) {
                      if (!_selectedPaymentMethods.contains(paymentMethod)) {
                        _selectedPaymentMethods.add(paymentMethod);
                      }
                    } else {
                      _selectedPaymentMethods.remove(paymentMethod);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Parâmetros técnicos de relatórios'),
            const SizedBox(height: 8),
            SwitchListTile(
              value: _enableSalesByPeriod,
              title: const Text('Habilitar vendas por período'),
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  _enableSalesByPeriod = value;
                });
              },
            ),
            SwitchListTile(
              value: _enableTopProducts,
              title: const Text('Habilitar produtos mais vendidos'),
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  _enableTopProducts = value;
                });
              },
            ),
            TextField(
              controller: _defaultPeriodController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Período padrão (dias)',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importConfiguration(
    BuildContext context,
    SystemConfigCubit systemConfigCubit,
  ) async {
    final shouldImport = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Importar configurações'),
          content: const Text(
            'Esta ação sobrescreve a configuração atual. Deseja continuar?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Importar'),
            ),
          ],
        );
      },
    );

    if (shouldImport != true) {
      return;
    }

    await systemConfigCubit.importConfiguration();
  }

  Future<void> _resetConfiguration(
    BuildContext context,
    SystemConfigCubit systemConfigCubit,
  ) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Restaurar padrão'),
          content: const Text(
            'Deseja restaurar as configurações para os valores padrão?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Restaurar'),
            ),
          ],
        );
      },
    );

    if (shouldReset != true) {
      return;
    }

    await systemConfigCubit.resetToDefaultConfiguration();
  }

  Future<void> _saveConfiguration(BuildContext context) async {
    final parsedPeriod = int.tryParse(_defaultPeriodController.text.trim());

    if (parsedPeriod == null || parsedPeriod <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe um período padrão válido (maior que zero).'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final reportConfiguration = ReportConfiguration(
      enableSalesByPeriod: _enableSalesByPeriod,
      enableTopProducts: _enableTopProducts,
      defaultPeriodInDays: parsedPeriod,
    );

    await context.read<SystemConfigCubit>().saveConfigurationData(
      paymentMethods: _selectedPaymentMethods,
      measurementUnits: _measurementUnits,
      reportConfiguration: reportConfiguration,
    );
  }
}
