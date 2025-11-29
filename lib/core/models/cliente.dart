import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'cliente.g.dart';

/// Modelo de dados para Cliente
@JsonSerializable()
class Cliente extends DefaultObject {
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String endereco;
  @JsonKey(name: 'data_cadastro')
  final DateTime dataCadastro;

  Cliente({
    required super.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
    DateTime? dataCadastro,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  /// Cria um objeto a partir de JSON
  factory Cliente.fromJson(Map<String, dynamic> json) => _$ClienteFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$ClienteToJson(this);

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
