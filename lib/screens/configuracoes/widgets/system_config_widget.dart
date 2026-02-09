import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/configuracoes/bloc/configuration_data_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/configuration_data_state.dart';

/// Widget para configurar as dados padrão do sistema
/// Cadastrar dados como tipos de pagamento, categorias de produtos, etc. para facilitar o uso do sistema.
class SystemConfigWidget extends StatefulWidget {
  final DateTime? initialData;
  final Function(DateTime) onDataChanged;

  const SystemConfigWidget({
    super.key,
    this.initialData,
    required this.onDataChanged,
  });

  @override
  State<SystemConfigWidget> createState() => _SystemConfigWidgetState();
}

class _SystemConfigWidgetState extends State<SystemConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações de Dados Padrão')),
      body: context.watch<ConfigurationDataCubit>().state.when(
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
                  // Lógica para editar os tipos de pagamento
                  
                },
              ),
            ),

            // Categoria de produtos
            ListTile(
              title: const Text('Categorias de Produtos'),
              subtitle: Text(data.productCategories.join(', ')),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Lógica para editar as categorias de produtos
                },
              ),
            ),

            // Adicione mais configurações de dados padrão aqui
          ],
        ),
      ),
    );
  }
}
