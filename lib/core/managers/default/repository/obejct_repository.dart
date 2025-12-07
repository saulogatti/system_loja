import 'package:json_annotation/json_annotation.dart';

part 'obejct_repository.g.dart';

sealed class ObejctRepository {
  final DateTime createdAt;
  DateTime updatedAt;
  ObejctRepository([DateTime? updatedAt, DateTime? createdAt])
    : updatedAt = updatedAt ?? DateTime.now(),
      createdAt = createdAt ?? DateTime.now();
  Map<String, dynamic> toJson();
}

@JsonSerializable()
 class ObejctRepositoryBase extends ObejctRepository {
  ObejctRepositoryBase(super.updatedAt, super.createdAt);

  factory ObejctRepositoryBase.fromJson(Map<String, dynamic> json) {
    return _$ObejctRepositoryBaseFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$ObejctRepositoryBaseToJson(this);
  }
}
