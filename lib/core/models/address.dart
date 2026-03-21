/// Endereço (domínio). Serialização em [AddressData] na camada `data`.
class Address {
  final String street;
  final String zipCode;
  final String neighborhood;
  final String city;
  final String state;

  const Address({
    this.street = '',
    this.zipCode = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
  });

  @override
  String toString() =>
      'Address(street: $street, zipCode: $zipCode, neighborhood: $neighborhood, city: $city, state: $state)';
}
