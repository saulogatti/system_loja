import 'package:system_loja/data/models/address_data.dart' show AddressData;

/// Endereço (domínio). Serialização em [AddressData] na camada `data`.
///
/// Todos os campos são opcionais e têm valor padrão de string vazia,
/// permitindo criação de endereços parciais.
class Address {

  const Address({
    this.street = '',
    this.zipCode = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
  });
  /// Logradouro (nome da rua, avenida, etc.).
  final String street;

  /// CEP no formato com ou sem máscara.
  final String zipCode;

  /// Bairro.
  final String neighborhood;

  /// Cidade.
  final String city;

  /// Estado (sigla de 2 letras, ex.: SP, RJ).
  final String state;

  @override
  String toString() =>
      'Address(street: $street, zipCode: $zipCode, neighborhood: $neighborhood, city: $city, state: $state)';
}
