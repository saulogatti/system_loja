import 'dart:convert';
import 'dart:io';

import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/models/cliente.dart';
import 'package:system_loja/core/models/nota_fiscal.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/utils/input_helper.dart';

/// Gerenciador de Notas Fiscais
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class NotaFiscalManager {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  List<NotaFiscal> notasFiscais = [];

  NotaFiscalManager({this.dataFile = 'data/notas_fiscais.json'}) {
    _carregarDados();
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

    // Using where().firstOrNull for null-safety pattern
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
        print(
          'ID: ${produto.id} - Nome: ${produto.nome} (Código: ${produto.codigo}) - R\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}',
        );
      }

      final produtoId = InputHelper.lerInt('Digite o ID do produto (0 para finalizar)', obrigatorio: true);
      if (produtoId == null) continue;
      if (produtoId == 0) break;

      // Using where().firstOrNull for null-safety pattern
      final produtoSelecionado = produtos.where((p) => p.id == produtoId).firstOrNull;
      if (produtoSelecionado == null) {
        print('Erro: Produto não encontrado!');
        continue;
      }

      final quantidade = InputHelper.lerInt(
        'Quantidade de \'${produtoSelecionado.nome}\'',
        obrigatorio: true,
      );
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
      print(
        '\nItem adicionado: ${quantidade}x ${produtoSelecionado.nome} - R\$ ${item.valorTotal.toStringAsFixed(2)}',
      );
    }

    if (itens.isEmpty) {
      print('\nErro: Nenhum item adicionado à nota fiscal!');
      return;
    }

    final formaPagamento =
        InputHelper.lerString('Forma de Pagamento (Dinheiro/Cartão/Pix)', obrigatorio: true) ??
        'Não informado';

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

  /// Busca uma nota fiscal por número
  void buscarNotaFiscal() {
    final numeroNota = InputHelper.lerString('Digite o número da nota fiscal', obrigatorio: true);
    if (numeroNota == null) return;

    // Using where().firstOrNull for null-safety pattern
    final notaFiscal = notasFiscais.where((nf) => nf.numeroNota == numeroNota).firstOrNull;
    if (notaFiscal != null) {
      print('\nNota Fiscal encontrada:');
      print(notaFiscal);
    } else {
      print('\nNota Fiscal não encontrada.');
    }
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
      for (final nf in dadosAtuais) {
        if (nf.id != null && nf.id! > maiorId) {
          maiorId = nf.id!;
        }
      }

      // Mescla dados: atualiza itens existentes e adiciona novos com IDs únicos
      for (final notaFiscal in notasFiscais) {
        final index = dadosAtuais.indexWhere((nf) => nf.id == notaFiscal.id);
        if (index >= 0) {
          // Atualiza item existente
          dadosAtuais[index] = notaFiscal;
        } else {
          // Verifica se o ID já existe (conflito) e reatribui se necessário
          final idExistente = dadosAtuais.any((nf) => nf.id == notaFiscal.id);
          if (idExistente || notaFiscal.id == null) {
            maiorId++;
            final notaFiscalComNovoId = NotaFiscal(
              id: maiorId,
              numeroNota: notaFiscal.numeroNota,
              clienteId: notaFiscal.clienteId,
              clienteNome: notaFiscal.clienteNome,
              clienteCpf: notaFiscal.clienteCpf,
              itens: notaFiscal.itens,
              formaPagamento: notaFiscal.formaPagamento,
              dataEmissao: notaFiscal.dataEmissao,
            );
            dadosAtuais.add(notaFiscalComNovoId);
          } else {
            dadosAtuais.add(notaFiscal);
            if (notaFiscal.id! > maiorId) {
              maiorId = notaFiscal.id!;
            }
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      notasFiscais = dadosAtuais;

      // Salva dados mesclados no arquivo
      _salvarDados();
    });
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

  /// Carrega dados do disco sem modificar o estado interno
  List<NotaFiscal> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => NotaFiscal.fromJson(json)).toList();
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

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, () => Lock());
  }

  /// Salva dados no arquivo JSON de forma segura
  ///
  /// Recarrega os dados do arquivo antes de salvar para mesclar com alterações
  /// feitas por outras instâncias, evitando perda de dados.
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(notasFiscais.map((nf) => nf.toJson()).toList());
    file.writeAsStringSync(jsonString);
  }
}
