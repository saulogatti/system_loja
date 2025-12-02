import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/item_nota_fiscal.dart';

part 'nota_fiscal.g.dart';

/// Modelo de dados para Nota Fiscal
@JsonSerializable()
class NotaFiscal extends DefaultObject {
  @JsonKey(name: 'numero_nota')
  final String numeroNota;
  @JsonKey(name: 'cliente_id')
  final int clienteId;
  @JsonKey(name: 'cliente_nome')
  final String clienteNome;
  @JsonKey(name: 'cliente_cpf')
  final String clienteCpf;
  final List<ItemNotaFiscal> itens;
  @JsonKey(name: 'valor_total')
  final double valorTotal;
  @JsonKey(name: 'forma_pagamento')
  final String formaPagamento;
  @JsonKey(name: 'data_emissao')
  final DateTime dataEmissao;

  NotaFiscal({
    required super.id,
    required this.numeroNota,
    required this.clienteId,
    required this.clienteNome,
    required this.clienteCpf,
    required this.itens,
    required this.formaPagamento,
    DateTime? dataEmissao,
  }) : valorTotal = itens.fold(0.0, (sum, item) => sum + item.valorTotal),
       dataEmissao = dataEmissao ?? DateTime.now();

  /// Cria um objeto a partir de JSON
  factory NotaFiscal.fromJson(Map<String, dynamic> json) => _$NotaFiscalFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$NotaFiscalToJson(this);

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
