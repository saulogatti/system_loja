import 'package:system_loja/core/models/default/people_data.dart';

class SystemUserData extends PersonDefault {
  final String systemKey;
  final String description;
  SystemUserData({
    required super.name,
    required super.email,
    required super.phone,
    required this.systemKey,
    required this.description,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  static SystemUserData defaultObject() {
    return SystemUserData(
      name: 'Default User',
      email: 'default@user.com',
      phone: '1234567890',
      systemKey: '',
      description: '',
    );
  }
}
