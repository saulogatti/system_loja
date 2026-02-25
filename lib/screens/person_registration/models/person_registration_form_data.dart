import 'package:system_loja/core/utils/documents.dart';

/// Representa os dados digitados no formulário de cadastro de pessoa.
class PersonRegistrationFormData {
  /// Armazena o tipo de pessoa selecionado.
  final PersonType personType;

  /// Armazena o nome da pessoa ou razão social.
  final String name;

  /// Armazena o documento sem máscara.
  final String document;

  /// Armazena o e-mail informado.
  final String email;

  /// Armazena o telefone informado.
  final String phone;

  /// Armazena a rua informada no endereço.
  final String street;

  /// Armazena o CEP informado no endereço.
  final String zipCode;

  /// Armazena o bairro informado no endereço.
  final String neighborhood;

  /// Armazena a cidade informada no endereço.
  final String city;

  /// Armazena o estado informado no endereço.
  final String state;

  const PersonRegistrationFormData({
    required this.personType,
    required this.name,
    required this.document,
    required this.email,
    required this.phone,
    required this.street,
    required this.zipCode,
    required this.neighborhood,
    required this.city,
    required this.state,
  });
}

/// Define os tipos de pessoa suportados na tela de cadastro.
enum PersonType {
  individual,
  company;

  /// Retorna o rótulo legível para o tipo selecionado.
  String get displayName {
    switch (this) {
      case PersonType.individual:
        return 'Pessoa Física';
      case PersonType.company:
        return 'Pessoa Jurídica';
    }
  }

  /// Retorna o nome do documento associado ao tipo.
  String get documentLabel {
    switch (this) {
      case PersonType.individual:
        return 'CPF';
      case PersonType.company:
        return 'CNPJ';
    }
  }

  String get nameLabel {
    switch (this) {
      case PersonType.individual:
        return 'Nome Completo';
      case PersonType.company:
        return 'Razão Social';
    }
  }

  String? validateDocument({required String? value}) {
    if (value == null || value.trim().isEmpty) {
      return '$documentLabel é obrigatório';
    }
    return Documents.validateDocument(value: value, selectedPersonType: this);
  }
}
