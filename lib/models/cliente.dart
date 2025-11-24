/// Modelo de dados para Cliente
class Cliente {
  int? id;
  String nome;
  String cpf;
  String email;
  String telefone;
  String endereco;
  DateTime dataCadastro;

  Cliente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
    DateTime? dataCadastro,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'data_cadastro': dataCadastro.toIso8601String(),
    };
  }

  /// Cria um objeto a partir de JSON
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      cpf: json['cpf'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      dataCadastro: DateTime.parse(json['data_cadastro'] as String),
    );
  }

  @override
  String toString() {
    return '''
ID: $id
Nome: $nome
CPF: $cpf
Email: $email
Telefone: $telefone
Endereço: $endereco
Data de Cadastro: ${dataCadastro.toString().split('.')[0]}''';
  }
}
