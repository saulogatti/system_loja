import 'package:flutter/material.dart';
import 'package:system_loja/core/managers/configuracao_manager.dart';
import 'package:system_loja/core/models/configuracao.dart';

/// Tela de Configurações do Sistema
///
/// Permite aos administradores ajustar preferências de notificação,
/// temas visuais, backup, limpeza de dados, segurança e tipo de banco.
class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final ConfiguracaoManager _manager = ConfiguracaoManager();
  late Configuracao _config;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _config = _manager.configuracao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações do Sistema'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Restaurar Padrão',
            onPressed: _restaurarPadrao,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSecaoNotificacoes(),
                  const SizedBox(height: 24),
                  _buildSecaoTema(),
                  const SizedBox(height: 24),
                  _buildSecaoBackup(),
                  const SizedBox(height: 24),
                  _buildSecaoLimpeza(),
                  const SizedBox(height: 24),
                  _buildSecaoSeguranca(),
                  const SizedBox(height: 24),
                  _buildSecaoBancoDados(),
                  const SizedBox(height: 32),
                  _buildBotaoSalvar(),
                ],
              ),
            ),
    );
  }

  /// Seção de Notificações
  Widget _buildSecaoNotificacoes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Notificações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Ativar notificações'),
              subtitle: const Text('Receber alertas do sistema'),
              value: _config.notificacoesAtivadas,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(notificacoesAtivadas: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Notificar vendas'),
              subtitle: const Text('Alertas sobre novas vendas'),
              value: _config.notificarVendas,
              onChanged: _config.notificacoesAtivadas
                  ? (value) {
                      setState(() {
                        _config = _config.copyWith(notificarVendas: value);
                      });
                    }
                  : null,
            ),
            SwitchListTile(
              title: const Text('Notificar estoque baixo'),
              subtitle: const Text('Alertas quando estoque está baixo'),
              value: _config.notificarEstoqueBaixo,
              onChanged: _config.notificacoesAtivadas
                  ? (value) {
                      setState(() {
                        _config =
                            _config.copyWith(notificarEstoqueBaixo: value);
                      });
                    }
                  : null,
            ),
            if (_config.notificarEstoqueBaixo && _config.notificacoesAtivadas)
              ListTile(
                title: const Text('Limite de estoque baixo'),
                subtitle: Slider(
                  value: _config.limiteEstoqueBaixo.toDouble(),
                  min: 1,
                  max: 50,
                  divisions: 49,
                  label: '${_config.limiteEstoqueBaixo} unidades',
                  onChanged: (value) {
                    setState(() {
                      _config = _config.copyWith(
                          limiteEstoqueBaixo: value.toInt());
                    });
                  },
                ),
                trailing: Text('${_config.limiteEstoqueBaixo}'),
              ),
          ],
        ),
      ),
    );
  }

  /// Seção de Tema
  Widget _buildSecaoTema() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette,
                    color: Theme.of(context).colorScheme.primary),
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
              value: _config.temaEscuro,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(temaEscuro: value);
                });
              },
            ),
            ListTile(
              title: const Text('Cor primária'),
              subtitle: const Text('Cor principal do aplicativo'),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getColorFromHex(_config.corPrimaria),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onTap: _mostrarSeletorCor,
            ),
          ],
        ),
      ),
    );
  }

  /// Seção de Backup
  Widget _buildSecaoBackup() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.backup,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Backup de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Backup automático'),
              subtitle: const Text('Realizar backups periodicamente'),
              value: _config.backupAutomatico,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(backupAutomatico: value);
                });
              },
            ),
            if (_config.backupAutomatico)
              ListTile(
                title: const Text('Frequência de backup'),
                subtitle: Text(_config.frequenciaBackup),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _selecionarFrequenciaBackup,
              ),
            ListTile(
              title: const Text('Realizar backup agora'),
              subtitle: const Text('Criar cópia dos dados manualmente'),
              leading: const Icon(Icons.save),
              onTap: _realizarBackup,
            ),
          ],
        ),
      ),
    );
  }

  /// Seção de Limpeza
  Widget _buildSecaoLimpeza() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cleaning_services,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Limpeza de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Limpeza automática de logs'),
              subtitle: const Text('Remover logs antigos automaticamente'),
              value: _config.limpezaAutomatica,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(limpezaAutomatica: value);
                });
              },
            ),
            if (_config.limpezaAutomatica)
              ListTile(
                title: const Text('Dias para manter logs'),
                subtitle: Slider(
                  value: _config.diasManterLogs.toDouble(),
                  min: 7,
                  max: 365,
                  divisions: 51,
                  label: '${_config.diasManterLogs} dias',
                  onChanged: (value) {
                    setState(() {
                      _config =
                          _config.copyWith(diasManterLogs: value.toInt());
                    });
                  },
                ),
                trailing: Text('${_config.diasManterLogs}'),
              ),
            ListTile(
              title: const Text('Limpar logs antigos agora'),
              subtitle: const Text('Remover logs com base na configuração'),
              leading: const Icon(Icons.delete_sweep),
              onTap: _limparLogsAntigos,
            ),
            ListTile(
              title: const Text(
                'Limpar todos os dados',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('Remover TODOS os dados do sistema'),
              leading: const Icon(Icons.warning, color: Colors.red),
              onTap: _limparTodosDados,
            ),
          ],
        ),
      ),
    );
  }

  /// Seção de Segurança
  Widget _buildSecaoSeguranca() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Segurança',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Exigir senha'),
              subtitle: const Text('Solicitar senha ao abrir o aplicativo'),
              value: _config.exigirSenha,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(exigirSenha: value);
                });
              },
            ),
            if (_config.exigirSenha)
              ListTile(
                title: const Text('Tempo de bloqueio'),
                subtitle: Slider(
                  value: _config.tempoBloqueioMinutos.toDouble(),
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: '${_config.tempoBloqueioMinutos} min',
                  onChanged: (value) {
                    setState(() {
                      _config = _config.copyWith(
                          tempoBloqueioMinutos: value.toInt());
                    });
                  },
                ),
                trailing: Text('${_config.tempoBloqueioMinutos} min'),
              ),
            SwitchListTile(
              title: const Text('Permitir múltiplos usuários'),
              subtitle: const Text('Habilitar gestão de usuários'),
              value: _config.permitirMultiplosUsuarios,
              onChanged: (value) {
                setState(() {
                  _config =
                      _config.copyWith(permitirMultiplosUsuarios: value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Seção de Banco de Dados
  Widget _buildSecaoBancoDados() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Banco de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            RadioListTile<String>(
              title: const Text('JSON (Arquivos locais)'),
              subtitle: const Text('Leve e simples, recomendado para uso básico'),
              value: 'json',
              groupValue: _config.tipoBancoDados,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(tipoBancoDados: value);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('SQL (SQLite)'),
              subtitle: const Text('Mais robusto, recomendado para muitos dados'),
              value: 'sql',
              groupValue: _config.tipoBancoDados,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(tipoBancoDados: value);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nota: Alterar o tipo de banco de dados requer reinicialização do aplicativo.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Botão de salvar
  Widget _buildBotaoSalvar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Salvar Configurações'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: _salvarConfiguracoes,
      ),
    );
  }

  /// Salva as configurações
  Future<void> _salvarConfiguracoes() async {
    setState(() => _isLoading = true);

    try {
      await _manager.atualizarConfiguracao(_config);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Configurações salvas com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar configurações: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Restaura configurações padrão
  Future<void> _restaurarPadrao() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurar Configurações'),
        content: const Text(
            'Deseja restaurar todas as configurações para os valores padrão?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      setState(() => _isLoading = true);

      try {
        await _manager.restaurarPadrao();
        setState(() {
          _config = _manager.configuracao;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Configurações restauradas para padrão!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao restaurar configurações: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Realiza backup dos dados
  Future<void> _realizarBackup() async {
    setState(() => _isLoading = true);

    try {
      final sucesso = await _manager.realizarBackup();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(sucesso
                ? 'Backup realizado com sucesso!'
                : 'Erro ao realizar backup'),
            backgroundColor: sucesso ? Colors.green : Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Limpa logs antigos
  Future<void> _limparLogsAntigos() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Logs Antigos'),
        content: Text(
            'Deseja remover logs com mais de ${_config.diasManterLogs} dias?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      setState(() => _isLoading = true);

      try {
        final sucesso = await _manager.limparLogsAntigos();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sucesso
                  ? 'Logs antigos removidos com sucesso!'
                  : 'Erro ao remover logs'),
              backgroundColor: sucesso ? Colors.green : Colors.red,
            ),
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Limpa todos os dados do sistema
  Future<void> _limparTodosDados() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ATENÇÃO!'),
        content: const Text(
            'Esta ação irá REMOVER TODOS OS DADOS do sistema '
            '(clientes, produtos, notas fiscais, usuários e logs).\n\n'
            'Esta ação NÃO PODE ser desfeita!\n\n'
            'Tem certeza que deseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim, Limpar Tudo'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      setState(() => _isLoading = true);

      try {
        final sucesso = await _manager.limparTodosDados();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sucesso
                  ? 'Todos os dados foram removidos!'
                  : 'Erro ao remover dados'),
              backgroundColor: sucesso ? Colors.orange : Colors.red,
            ),
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Seleciona a frequência de backup
  Future<void> _selecionarFrequenciaBackup() async {
    final opcoes = ['diario', 'semanal', 'mensal'];
    final selecionado = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Frequência de Backup'),
        children: opcoes.map((opcao) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, opcao),
            child: Text(
              opcao[0].toUpperCase() + opcao.substring(1),
              style: TextStyle(
                fontWeight: _config.frequenciaBackup == opcao
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );

    if (selecionado != null) {
      setState(() {
        _config = _config.copyWith(frequenciaBackup: selecionado);
      });
    }
  }

  /// Mostra seletor de cor
  Future<void> _mostrarSeletorCor() async {
    final cores = {
      'Azul': '#2196F3',
      'Verde': '#4CAF50',
      'Laranja': '#FF9800',
      'Roxo': '#9C27B0',
      'Vermelho': '#F44336',
      'Rosa': '#E91E63',
      'Ciano': '#00BCD4',
      'Índigo': '#3F51B5',
    };

    final selecionada = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Escolher Cor'),
        children: cores.entries.map((entry) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, entry.value),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _getColorFromHex(entry.value),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  entry.key,
                  style: TextStyle(
                    fontWeight: _config.corPrimaria == entry.value
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selecionada != null) {
      setState(() {
        _config = _config.copyWith(corPrimaria: selecionada);
      });
    }
  }

  /// Converte cor hexadecimal para Color
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
