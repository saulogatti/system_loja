import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/user.dart';

part 'user_entry.g.dart';

/// Linha Drift / DTO JSON para usuário (sem herdar [User]).
@JsonSerializable(explicitToJson: true)
class UserEntry {

  const UserEntry({
    required this.id,
    required this.name,
    required this.passwordHash,
    required this.registrationDate,
    this.email,
    this.permission = 0,
    this.lastUpdatedDate,
  });

  factory UserEntry.fromJson(Map<String, dynamic> json) =>
      _$UserEntryFromJson(json);

  factory UserEntry.fromUser(User user) => UserEntry(
      id: user.id,
      name: user.name,
      passwordHash: user.passwordHash,
      registrationDate: user.registrationDate,
      email: user.email,
      permission: user.permission,
      lastUpdatedDate: user.lastUpdatedDate,
    );
  final int id;
  final String name;
  final String? email;
  final String passwordHash;
  @JsonKey(defaultValue: 0)
  final int permission;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  Map<String, dynamic> toJson() => _$UserEntryToJson(this);

  User toUser() => User(
    name: name,
    email: email,
    passwordHash: passwordHash,
    permission: permission,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
    id: id,
  );
}
