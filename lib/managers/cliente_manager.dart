import 'dart:convert';
import 'dart:io';
import 'package:synchronized/synchronized.dart';
import '../models/cliente.dart';
import '../utils/input_helper.dart';

/// Gerenciador de Clientes
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class ClienteManager {
  final String dataFile;
  List<Cliente> clientes = [];

  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, () => Lock());
  }

  ClienteManager({this.dataFile = 'data/clientes.json'}) {
    _carregarDados();
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        clientes = jsonList.map((json) => Cliente.fromJson(json)).toList();
      } catch (e) {
        print('Erro ao carregar dados de clientes: $e');
        clientes = [];
      }
    }
  }

  /// Salva dados no arquivo JSON de forma segura
  ///
  /// Recarrega os dados do arquivo antes de salvar para mesclar com alterações
  /// feitas por outras instâncias, evitando perda de dados.
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(
      clientes.map((cliente) => cliente.toJson()).toList(),
    );
    file.writeAsStringSync(jsonString);
  }

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
        if (c.id != null && c.id! > maiorId) {
          maiorId = c.id!;
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
          if (idExistente || cliente.id == null) {
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
            if (cliente.id! > maiorId) {
              maiorId = cliente.id!;
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

  /// Carrega dados do disco sem modificar o estado interno
  List<Cliente> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Cliente.fromJson(json)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  /// Public method to save data (for Flutter GUI)
  @Deprecated('Use salvarDadosSincronizado() para operações seguras')
  void salvarDados() => _salvarDados();

  /// Adiciona um novo cliente
  void adicionarCliente() {
    print('\n--- Cadastro de Cliente ---');

    final nome = InputHelper.lerString('Nome', obrigatorio: true);
    if (nome == null) return;

    final cpf = InputHelper.lerString('CPF', obrigatorio: true);
    if (cpf == null) return;

    // Verifica se o CPF já existe
    if (clientes.any((c) => c.cpf == cpf)) {
      print('Erro: CPF já cadastrado!');
      return;
    }

    final email = InputHelper.lerString('Email') ?? '';
    final telefone = InputHelper.lerString('Telefone') ?? '';
    final endereco = InputHelper.lerString('Endereço') ?? '';

    final cliente = Cliente(
      id: clientes.isEmpty ? 1 : clientes.map((c) => c.id!).reduce((a, b) => a > b ? a : b) + 1,
      nome: nome,
      cpf: cpf,
      email: email,
      telefone: telefone,
      endereco: endereco,
    );

    clientes.add(cliente);
    _salvarDados();
    print('\nCliente \'$nome\' cadastrado com sucesso! ID: ${cliente.id}');
  }

  /// Lista todos os clientes
  void listarClientes() {
    if (clientes.isEmpty) {
      print('\nNenhum cliente cadastrado.');
      return;
    }

    print('\n--- Lista de Clientes ---');
    for (var cliente in clientes) {
      print(cliente);
      print('-' * 40);
    }
  }

  /// Busca um cliente por CPF
  void buscarCliente() {
    final cpf = InputHelper.lerString('Digite o CPF do cliente', obrigatorio: true);
    if (cpf == null) return;

    // Using where().firstOrNull for null-safety pattern
    final cliente = clientes.where((c) => c.cpf == cpf).firstOrNull;
    if (cliente != null) {
      print('\nCliente encontrado:');
      print(cliente);
    } else {
      print('\nCliente não encontrado.');
    }
  }

  /// Menu de gerenciamento de clientes
  void menu() {
    while (true) {
      print('\n--- Cadastro de Cliente ---');
      print('1. Adicionar Cliente');
      print('2. Listar Clientes');
      print('3. Buscar Cliente');
      print('4. Voltar ao Menu Principal');

      final opcao = InputHelper.lerString('Escolha uma opção');
      
      switch (opcao) {
        case '1':
          adicionarCliente();
          break;
        case '2':
          listarClientes();
          break;
        case '3':
          buscarCliente();
          break;
        case '4':
          return;
        default:
          print('\nOpção inválida! Tente novamente.');
      }
    }
  }

  /// Obtém um cliente por ID
  Cliente? obterClientePorId(int id) {
    return clientes.where((c) => c.id == id).firstOrNull;
  }

  /// Obtém todos os clientes
  List<Cliente> obterTodosClientes() {
    return clientes;
  }
}
