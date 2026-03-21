import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.passwordHash,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  factory UserModel.fromUser(User user) {
    return UserModel(
      name: user.name,
      email: user.email,
      passwordHash: user.passwordHash,
      registrationDate: user.registrationDate,
      lastUpdatedDate: user.lastUpdatedDate,
      id: user.id,
    );
  }
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
