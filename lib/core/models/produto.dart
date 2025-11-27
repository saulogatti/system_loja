/// Modelo de dados para Produto
class Produto {
  int? id;
  String nome;
  String codigo;
  double preco;
  int estoque;
  String descricao;
  String categoria;
  DateTime dataCadastro;

  Produto({
    this.id,
    required this.nome,
    required this.codigo,
    required this.preco,
    required this.estoque,
    required this.descricao,
    required this.categoria,
    DateTime? dataCadastro,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'codigo': codigo,
      'preco': preco,
      'estoque': estoque,
      'descricao': descricao,
      'categoria': categoria,
      'data_cadastro': dataCadastro.toIso8601String(),
    };
  }

  /// Cria um objeto a partir de JSON
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      codigo: json['codigo'] as String,
      preco: (json['preco'] as num).toDouble(),
      estoque: json['estoque'] as int,
      descricao: json['descricao'] as String,
      categoria: json['categoria'] as String,
      dataCadastro: DateTime.parse(json['data_cadastro'] as String),
    );
  }

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
