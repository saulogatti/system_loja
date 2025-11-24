/// Modelo de dados para Item da Nota Fiscal
class ItemNotaFiscal {
  int produtoId;
  String produtoNome;
  String produtoCodigo;
  int quantidade;
  double precoUnitario;
  double valorTotal;

  ItemNotaFiscal({
    required this.produtoId,
    required this.produtoNome,
    required this.produtoCodigo,
    required this.quantidade,
    required this.precoUnitario,
  }) : valorTotal = quantidade * precoUnitario;

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'produto_id': produtoId,
      'produto_nome': produtoNome,
      'produto_codigo': produtoCodigo,
      'quantidade': quantidade,
      'preco_unitario': precoUnitario,
      'valor_total': valorTotal,
    };
  }

  /// Cria um objeto a partir de JSON
  factory ItemNotaFiscal.fromJson(Map<String, dynamic> json) {
    return ItemNotaFiscal(
      produtoId: json['produto_id'] as int,
      produtoNome: json['produto_nome'] as String,
      produtoCodigo: json['produto_codigo'] as String,
      quantidade: json['quantidade'] as int,
      precoUnitario: (json['preco_unitario'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return '  - ${quantidade}x $produtoNome (R\$ ${precoUnitario.toStringAsFixed(2)}) = R\$ ${valorTotal.toStringAsFixed(2)}';
  }
}

/// Modelo de dados para Nota Fiscal
class NotaFiscal {
  int? id;
  String numeroNota;
  int clienteId;
  String clienteNome;
  String clienteCpf;
  List<ItemNotaFiscal> itens;
  double valorTotal;
  String formaPagamento;
  DateTime dataEmissao;

  NotaFiscal({
    this.id,
    required this.numeroNota,
    required this.clienteId,
    required this.clienteNome,
    required this.clienteCpf,
    required this.itens,
    required this.formaPagamento,
    DateTime? dataEmissao,
  })  : valorTotal = itens.fold(0.0, (sum, item) => sum + item.valorTotal),
        dataEmissao = dataEmissao ?? DateTime.now();

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero_nota': numeroNota,
      'cliente_id': clienteId,
      'cliente_nome': clienteNome,
      'cliente_cpf': clienteCpf,
      'itens': itens.map((item) => item.toJson()).toList(),
      'valor_total': valorTotal,
      'forma_pagamento': formaPagamento,
      'data_emissao': dataEmissao.toIso8601String(),
    };
  }

  /// Cria um objeto a partir de JSON
  factory NotaFiscal.fromJson(Map<String, dynamic> json) {
    return NotaFiscal(
      id: json['id'] as int?,
      numeroNota: json['numero_nota'] as String,
      clienteId: json['cliente_id'] as int,
      clienteNome: json['cliente_nome'] as String,
      clienteCpf: json['cliente_cpf'] as String,
      itens: (json['itens'] as List)
          .map((item) => ItemNotaFiscal.fromJson(item as Map<String, dynamic>))
          .toList(),
      formaPagamento: json['forma_pagamento'] as String,
      dataEmissao: DateTime.parse(json['data_emissao'] as String),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('ID: $id');
    buffer.writeln('Número da Nota: $numeroNota');
    buffer.writeln('Cliente: $clienteNome (CPF: $clienteCpf)');
    buffer.writeln('Valor Total: R\$ ${valorTotal.toStringAsFixed(2)}');
    buffer.writeln('Forma de Pagamento: $formaPagamento');
    buffer.writeln('Data de Emissão: ${dataEmissao.toString().split('.')[0]}');
    buffer.writeln('Itens:');
    for (var item in itens) {
      buffer.writeln(item.toString());
    }
    return buffer.toString();
  }
}
