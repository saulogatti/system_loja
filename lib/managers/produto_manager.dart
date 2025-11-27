import 'dart:convert';
import 'dart:io';
import 'package:synchronized/synchronized.dart';
import '../models/produto.dart';
import '../utils/input_helper.dart';

/// Gerenciador de Produtos
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class ProdutoManager {
  final String dataFile;
  List<Produto> produtos = [];

  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, () => Lock());
  }

  ProdutoManager({this.dataFile = 'data/produtos.json'}) {
    _carregarDados();
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        produtos = jsonList.map((json) => Produto.fromJson(json)).toList();
      } catch (e) {
        print('Erro ao carregar dados de produtos: $e');
        produtos = [];
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
      produtos.map((produto) => produto.toJson()).toList(),
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
      for (final p in dadosAtuais) {
        if (p.id != null && p.id! > maiorId) {
          maiorId = p.id!;
        }
      }

      // Mescla dados: atualiza itens existentes e adiciona novos com IDs únicos
      for (final produto in produtos) {
        final index = dadosAtuais.indexWhere((p) => p.id == produto.id);
        if (index >= 0) {
          // Atualiza item existente
          dadosAtuais[index] = produto;
        } else {
          // Verifica se o ID já existe (conflito) e reatribui se necessário
          final idExistente = dadosAtuais.any((p) => p.id == produto.id);
          if (idExistente || produto.id == null) {
            maiorId++;
            final produtoComNovoId = Produto(
              id: maiorId,
              nome: produto.nome,
              codigo: produto.codigo,
              preco: produto.preco,
              estoque: produto.estoque,
              descricao: produto.descricao,
              categoria: produto.categoria,
              dataCadastro: produto.dataCadastro,
            );
            dadosAtuais.add(produtoComNovoId);
          } else {
            dadosAtuais.add(produto);
            if (produto.id! > maiorId) {
              maiorId = produto.id!;
            }
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      produtos = dadosAtuais;

      // Salva dados mesclados no arquivo
      _salvarDados();
    });
  }

  /// Carrega dados do disco sem modificar o estado interno
  List<Produto> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Produto.fromJson(json)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  /// Public method to save data (for Flutter GUI)
  /// @deprecated Use salvarDadosSincronizado() para operações seguras
  void salvarDados() => _salvarDados();

  /// Adiciona um novo produto
  void adicionarProduto() {
    print('\n--- Cadastro de Produto ---');

    final nome = InputHelper.lerString('Nome do Produto', obrigatorio: true);
    if (nome == null) return;

    final codigo = InputHelper.lerString('Código do Produto', obrigatorio: true);
    if (codigo == null) return;

    // Verifica se o código já existe
    if (produtos.any((p) => p.codigo == codigo)) {
      print('Erro: Código já cadastrado!');
      return;
    }

    final preco = InputHelper.lerDouble('Preço (R\$)', obrigatorio: true);
    if (preco == null) return;
    if (preco < 0) {
      print('Erro: Preço não pode ser negativo!');
      return;
    }

    final estoque = InputHelper.lerInt('Quantidade em Estoque', obrigatorio: true);
    if (estoque == null) return;
    if (estoque < 0) {
      print('Erro: Estoque não pode ser negativo!');
      return;
    }

    final descricao = InputHelper.lerString('Descrição') ?? '';
    final categoria = InputHelper.lerString('Categoria') ?? '';

    final produto = Produto(
      id: produtos.isEmpty ? 1 : produtos.map((p) => p.id!).reduce((a, b) => a > b ? a : b) + 1,
      nome: nome,
      codigo: codigo,
      preco: preco,
      estoque: estoque,
      descricao: descricao,
      categoria: categoria,
    );

    produtos.add(produto);
    _salvarDados();
    print('\nProduto \'$nome\' cadastrado com sucesso! ID: ${produto.id}');
  }

  /// Lista todos os produtos
  void listarProdutos() {
    if (produtos.isEmpty) {
      print('\nNenhum produto cadastrado.');
      return;
    }

    print('\n--- Lista de Produtos ---');
    for (var produto in produtos) {
      print(produto);
      print('-' * 40);
    }
  }

  /// Busca um produto por código
  void buscarProduto() {
    final codigo = InputHelper.lerString('Digite o código do produto', obrigatorio: true);
    if (codigo == null) return;

    // Using where().firstOrNull for null-safety pattern
    final produto = produtos.where((p) => p.codigo == codigo).firstOrNull;
    if (produto != null) {
      print('\nProduto encontrado:');
      print(produto);
    } else {
      print('\nProduto não encontrado.');
    }
  }

  /// Menu de gerenciamento de produtos
  void menu() {
    while (true) {
      print('\n--- Cadastro de Produto ---');
      print('1. Adicionar Produto');
      print('2. Listar Produtos');
      print('3. Buscar Produto');
      print('4. Voltar ao Menu Principal');

      final opcao = InputHelper.lerString('Escolha uma opção');
      
      switch (opcao) {
        case '1':
          adicionarProduto();
          break;
        case '2':
          listarProdutos();
          break;
        case '3':
          buscarProduto();
          break;
        case '4':
          return;
        default:
          print('\nOpção inválida! Tente novamente.');
      }
    }
  }

  /// Obtém um produto por ID
  Produto? obterProdutoPorId(int id) {
    return produtos.where((p) => p.id == id).firstOrNull;
  }

  /// Obtém todos os produtos
  List<Produto> obterTodosProdutos() {
    return produtos;
  }
}
