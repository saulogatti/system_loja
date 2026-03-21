import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/user.dart';

part 'user_entry.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntry extends User {
  UserEntry({
    required super.name,
    required super.email,
    required super.passwordHash,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  factory UserEntry.fromJson(Map<String, dynamic> json) =>
      _$UserEntryFromJson(json);
  factory UserEntry.fromUser(User user) {
    return UserEntry(
      name: user.name,
      email: user.email,
      passwordHash: user.passwordHash,
      registrationDate: user.registrationDate,
      lastUpdatedDate: user.lastUpdatedDate,
      id: user.id,
    );
  }
  Map<String, dynamic> toJson() => _$UserEntryToJson(this);
}
