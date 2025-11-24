import 'dart:convert';
import 'dart:io';
import '../models/cliente.dart';
import '../utils/input_helper.dart';

/// Gerenciador de Clientes
class ClienteManager {
  final String dataFile;
  List<Cliente> clientes = [];

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

  /// Salva dados no arquivo JSON
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(
      clientes.map((cliente) => cliente.toJson()).toList(),
    );
    file.writeAsStringSync(jsonString);
  }

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
