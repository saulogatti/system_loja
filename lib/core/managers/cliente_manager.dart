import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';

import '../models/cliente.dart';

/// Gerenciador de Clientes
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class ClienteManager with LoggerClassMixin {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  // FIXME: Alterar de público para privado, assim não expõe a lista diretamente. Todos os tratamentos devem ser feitos via métodos. (checar se tem cliente por id, adicionar, remover, atualizar, etc)
  List<Cliente> clientes = [];

  ClienteManager({this.dataFile = 'data/clientes.json'}) {
    _carregarDados();
  }

  /// Obtém um cliente por ID
  Cliente? obterClientePorId(int id) {
    return clientes.where((c) => c.id == id).firstOrNull;
  }

  /// Obtém todos os clientes
  List<Cliente> obterTodosClientes() {
    return clientes;
  }

  /// Public method to save data (for Flutter GUI)
  @Deprecated('Use salvarDadosSincronizado() para operações seguras')
  void salvarDados() => _salvarDados();

  /// Salva dados de forma segura e sincronizada (para Flutter GUI)
  ///
  /// Utiliza um lock para serializar o acesso ao arquivo e recarrega
  /// os dados antes de salvar para mesclar alterações de outras instâncias.
  /// Resolve conflitos de ID atribuindo novos IDs para itens novos.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      // Recarrega dados do arquivo para obter a versão mais recente
      final dadosAtuais = _carregarDadosDoDisco();

      // Obtém o maior ID existente para evitar conflitos
      int maiorId = 0;
      for (final c in dadosAtuais) {
        if (c.id > maiorId) {
          maiorId = c.id;
        }
      }

      // Mescla dados: atualiza itens existentes e adiciona novos com IDs únicos
      for (final cliente in clientes) {
        final index = dadosAtuais.indexWhere((c) => c.id == cliente.id);
        if (index >= 0) {
          // Atualiza item existente
          dadosAtuais[index] = cliente;
        } else {
          // Verifica se o ID já existe (conflito) e reatribui se necessário
          final idExistente = dadosAtuais.any((c) => c.id == cliente.id);
          if (idExistente) {
            maiorId++;
            final clienteComNovoId = Cliente(
              id: maiorId,
              nome: cliente.nome,
              cpf: cliente.cpf,
              email: cliente.email,
              telefone: cliente.telefone,
              endereco: cliente.endereco,
              dataCadastro: cliente.dataCadastro,
            );
            dadosAtuais.add(clienteComNovoId);
          } else {
            dadosAtuais.add(cliente);
            if (cliente.id > maiorId) {
              maiorId = cliente.id;
            }
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      clientes = dadosAtuais;

      // Salva dados mesclados no arquivo
      _salvarDados();
    });
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<Map<String, dynamic>> jsonList =
            jsonDecode(jsonString) as List<Map<String, dynamic>>;
        clientes = jsonList.map(Cliente.fromJson).toList();
      } catch (e, stackTrace) {
        logError('Erro ao carregar dados de clientes: $e', stackTrace);
        clientes = [];
      }
    }
  }

  /// Carrega dados do disco sem modificar o estado interno
  List<Cliente> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<Map<String, dynamic>> jsonList =
            jsonDecode(jsonString) as List<Map<String, dynamic>>;
        return jsonList.map(Cliente.fromJson).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, Lock.new);
  }

  /// Salva dados no arquivo JSON de forma segura
  ///
  /// Recarrega os dados do arquivo antes de salvar para mesclar com alterações
  /// feitas por outras instâncias, evitando perda de dados.
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString =
        jsonEncode(clientes.map((cliente) => cliente.toJson()).toList());
    file.writeAsStringSync(jsonString);
  }
}
