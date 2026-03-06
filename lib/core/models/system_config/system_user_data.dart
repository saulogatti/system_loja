import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/person/person.dart';

class SystemUserData extends DefaultObject {
  final Person person;
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
  factory SystemUserData.defaultObject() {
    return SystemUserData(person: Person.defaultObject(), systemKey: '', description: '');
  }
}
