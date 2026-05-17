import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/screens/configuracoes/settings_screen.dart';

/// Widget da seção de configurações de aparência/tema
class ThemeSettings extends StatelessWidget {
  /// Configuração atual do sistema
  final AppSettings config;

  /// Callback para atualizar a configuração
  final void Function(AppSettings) onConfigChanged;

  /// Callback para mostrar seletor de cor
  final VoidCallback onMostrarSeletorCor;

  const ThemeSettings({
    required this.config,
    required this.onConfigChanged,
    required this.onMostrarSeletorCor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Aparência',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Tema escuro'),
              subtitle: const Text('Ativar modo escuro'),
              value: config.temaEscuro,
              onChanged: (value) {
                onConfigChanged(config.copyWith(temaEscuro: value));
              },
            ),
            ListTile(
              title: const Text('Cor primária'),
              subtitle: const Text('Cor principal do aplicativo'),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: config.corPrimaria.color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onTap: onMostrarSeletorCor,
            ),
          ],
        ),
      ),
    );
  }
}
