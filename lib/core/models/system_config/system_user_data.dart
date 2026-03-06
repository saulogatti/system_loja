import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/document/cpf.dart';
import 'package:system_loja/core/models/person/person.dart';

class SystemUserData extends DefaultObject {
  final Individual person;
  final String systemKey;
  final String description;
  SystemUserData({
    required this.person,
    required this.systemKey,
    required this.description,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  static SystemUserData defaultObject() {
    return SystemUserData(
      person: Individual(name: 'Default User', document: Cpf.defaultObject()),
      systemKey: '',
      description: '',
    );
  }
}
