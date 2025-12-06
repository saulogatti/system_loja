// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'cliente.g.dart';

/// Modelo de dados para Cliente
@JsonSerializable(constructor: 'withDados', explicitToJson: true)
class Cliente extends DefaultObject {
  final DadosCliente dadosCliente;
  @JsonKey(name: 'data_cadastro')
  final DateTime dataCadastro;

  Cliente({
    required super.id,
    required String nome,
    required String cpf,
    required String email,
    required String telefone,
    required String endereco,
    DateTime? dataCadastro,
  }) : dadosCliente = DadosCliente(
         nome: nome,
         cpf: cpf,
         email: email,
         telefone: telefone,
         endereco: endereco,
       ),
       dataCadastro = dataCadastro ?? DateTime.now();

  /// Cria um objeto a partir de JSON
  factory Cliente.fromJson(Map<String, dynamic> json) => _$ClienteFromJson(json);
  Cliente.withDados({required super.id, required this.dadosCliente, DateTime? dataCadastro})
    : dataCadastro = dataCadastro ?? DateTime.now();
  String get cpf => dadosCliente.cpf;
  String get email => dadosCliente.email;
  String get endereco => dadosCliente.endereco;
  String get nome => dadosCliente.nome;
  String get telefone => dadosCliente.telefone;

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$ClienteToJson(this);

  @override
  String toString() => 'Cliente(id: $id, dadosCliente: $dadosCliente, dataCadastro: $dataCadastro)';
}

@JsonSerializable()
class DadosCliente {
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String endereco;

  DadosCliente({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.endereco,
  });

  factory DadosCliente.fromJson(Map<String, dynamic> json) => _$DadosClienteFromJson(json);
  Map<String, dynamic> toJson() => _$DadosClienteToJson(this);

  @override
  String toString() {
    return 'DadosCliente(nome: $nome, cpf: $cpf, email: $email, telefone: $telefone, endereco: $endereco)';
  }
}
