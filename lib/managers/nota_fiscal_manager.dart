import 'dart:convert';
import 'dart:io';
import '../models/nota_fiscal.dart';
import '../models/cliente.dart';
import '../models/produto.dart';
import '../utils/input_helper.dart';

/// Gerenciador de Notas Fiscais
class NotaFiscalManager {
  final String dataFile;
  List<NotaFiscal> notasFiscais = [];

  NotaFiscalManager({this.dataFile = 'data/notas_fiscais.json'}) {
    _carregarDados();
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        notasFiscais = jsonList.map((json) => NotaFiscal.fromJson(json)).toList();
      } catch (e) {
        print('Erro ao carregar dados de notas fiscais: $e');
        notasFiscais = [];
      }
    }
  }

  /// Salva dados no arquivo JSON
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(
      notasFiscais.map((nf) => nf.toJson()).toList(),
    );
    file.writeAsStringSync(jsonString);
  }

  /// Carrega clientes do arquivo JSON
  List<Cliente> _carregarClientes() {
    final file = File('data/clientes.json');
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

  /// Carrega produtos do arquivo JSON
  List<Produto> _carregarProdutos() {
    final file = File('data/produtos.json');
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

  /// Adiciona uma nova nota fiscal
  void adicionarNotaFiscal() {
    print('\n--- Cadastro de Nota Fiscal de Compra ---');

    final clientes = _carregarClientes();
    final produtos = _carregarProdutos();

    if (clientes.isEmpty) {
      print('Erro: Nenhum cliente cadastrado. Cadastre um cliente primeiro!');
      return;
    }

    if (produtos.isEmpty) {
      print('Erro: Nenhum produto cadastrado. Cadastre um produto primeiro!');
      return;
    }

    // Exibe clientes disponíveis
    print('\n--- Clientes Disponíveis ---');
    for (var cliente in clientes) {
      print('ID: ${cliente.id} - Nome: ${cliente.nome} (CPF: ${cliente.cpf})');
    }

    final clienteId = InputHelper.lerInt('Digite o ID do cliente', obrigatorio: true);
    if (clienteId == null) return;

    final clienteSelecionado = clientes.where((c) => c.id == clienteId).firstOrNull;
    if (clienteSelecionado == null) {
      print('Erro: Cliente não encontrado!');
      return;
    }

    final numeroNota = InputHelper.lerString('Número da Nota Fiscal', obrigatorio: true);
    if (numeroNota == null) return;

    // Verifica se o número da nota já existe
    if (notasFiscais.any((nf) => nf.numeroNota == numeroNota)) {
      print('Erro: Número da nota fiscal já cadastrado!');
      return;
    }

    // Adiciona itens à nota fiscal
    final List<ItemNotaFiscal> itens = [];

    while (true) {
      print('\n--- Produtos Disponíveis ---');
      for (var produto in produtos) {
        print('ID: ${produto.id} - Nome: ${produto.nome} (Código: ${produto.codigo}) - R\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}');
      }

      final produtoId = InputHelper.lerInt('Digite o ID do produto (0 para finalizar)', obrigatorio: true);
      if (produtoId == null) continue;
      if (produtoId == 0) break;

      final produtoSelecionado = produtos.where((p) => p.id == produtoId).firstOrNull;
      if (produtoSelecionado == null) {
        print('Erro: Produto não encontrado!');
        continue;
      }

      final quantidade = InputHelper.lerInt('Quantidade de \'${produtoSelecionado.nome}\'', obrigatorio: true);
      if (quantidade == null) continue;
      if (quantidade <= 0) {
        print('Erro: Quantidade deve ser maior que zero!');
        continue;
      }

      if (quantidade > produtoSelecionado.estoque) {
        print('Erro: Estoque insuficiente! Disponível: ${produtoSelecionado.estoque}');
        continue;
      }

      final item = ItemNotaFiscal(
        produtoId: produtoSelecionado.id!,
        produtoNome: produtoSelecionado.nome,
        produtoCodigo: produtoSelecionado.codigo,
        quantidade: quantidade,
        precoUnitario: produtoSelecionado.preco,
      );

      itens.add(item);
      print('\nItem adicionado: ${quantidade}x ${produtoSelecionado.nome} - R\$ ${item.valorTotal.toStringAsFixed(2)}');
    }

    if (itens.isEmpty) {
      print('\nErro: Nenhum item adicionado à nota fiscal!');
      return;
    }

    final formaPagamento = InputHelper.lerString('Forma de Pagamento (Dinheiro/Cartão/Pix)', obrigatorio: true) ?? 'Não informado';

    final notaFiscal = NotaFiscal(
      id: notasFiscais.isEmpty ? 1 : notasFiscais.map((nf) => nf.id!).reduce((a, b) => a > b ? a : b) + 1,
      numeroNota: numeroNota,
      clienteId: clienteSelecionado.id!,
      clienteNome: clienteSelecionado.nome,
      clienteCpf: clienteSelecionado.cpf,
      itens: itens,
      formaPagamento: formaPagamento,
    );

    notasFiscais.add(notaFiscal);
    _salvarDados();
    print('\nNota Fiscal \'$numeroNota\' cadastrada com sucesso! ID: ${notaFiscal.id}');
    print('Valor Total: R\$ ${notaFiscal.valorTotal.toStringAsFixed(2)}');
  }

  /// Lista todas as notas fiscais
  void listarNotasFiscais() {
    if (notasFiscais.isEmpty) {
      print('\nNenhuma nota fiscal cadastrada.');
      return;
    }

    print('\n--- Lista de Notas Fiscais ---');
    for (var nf in notasFiscais) {
      print(nf);
      print('-' * 40);
    }
  }

  /// Busca uma nota fiscal por número
  void buscarNotaFiscal() {
    final numeroNota = InputHelper.lerString('Digite o número da nota fiscal', obrigatorio: true);
    if (numeroNota == null) return;

    final notaFiscal = notasFiscais.where((nf) => nf.numeroNota == numeroNota).firstOrNull;
    if (notaFiscal != null) {
      print('\nNota Fiscal encontrada:');
      print(notaFiscal);
    } else {
      print('\nNota Fiscal não encontrada.');
    }
  }

  /// Menu de gerenciamento de notas fiscais
  void menu() {
    while (true) {
      print('\n--- Cadastro de Nota Fiscal de Compra ---');
      print('1. Adicionar Nota Fiscal');
      print('2. Listar Notas Fiscais');
      print('3. Buscar Nota Fiscal');
      print('4. Voltar ao Menu Principal');

      final opcao = InputHelper.lerString('Escolha uma opção');
      
      switch (opcao) {
        case '1':
          adicionarNotaFiscal();
          break;
        case '2':
          listarNotasFiscais();
          break;
        case '3':
          buscarNotaFiscal();
          break;
        case '4':
          return;
        default:
          print('\nOpção inválida! Tente novamente.');
      }
    }
  }
}
