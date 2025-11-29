import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'produto.g.dart';

/// Modelo de dados para Produto
@JsonSerializable()
class Produto extends DefaultObject {
  final String nome;
  final String codigo;
  final double preco;
  final int estoque;
  final String descricao;
  final String categoria;
@JsonKey(name: 'data_cadastro')
  final DateTime dataCadastro;

  Produto({
    required super.id,
    required this.nome,
    required this.codigo,
    required this.preco,
    required this.estoque,
    required this.descricao,
    required this.categoria,
    DateTime? dataCadastro,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  /// Cria um objeto a partir de JSON
  factory Produto.fromJson(Map<String, dynamic> json) => _$ProdutoFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$ProdutoToJson(this);

  @override
  String toString() {
    return '''
ID: $id
Nome: $nome
Código: $codigo
Preço: R\$ ${preco.toStringAsFixed(2)}
Estoque: $estoque
Descrição: $descricao
Categoria: $categoria
Data de Cadastro: ${dataCadastro.toString().split('.')[0]}''';
  }
}
