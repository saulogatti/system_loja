import 'package:json_annotation/json_annotation.dart';

part 'item_nota_fiscal.g.dart';

@JsonSerializable()
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

  /// Cria um objeto a partir de JSON
  factory ItemNotaFiscal.fromJson(Map<String, dynamic> json) => _$ItemNotaFiscalFromJson(json);

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() => _$ItemNotaFiscalToJson(this);

  @override
  String toString() {
    return '  - ${quantidade}x $produtoNome (R\$ ${precoUnitario.toStringAsFixed(2)}) = R\$ ${valorTotal.toStringAsFixed(2)}';
  }
}
