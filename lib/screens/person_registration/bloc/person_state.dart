import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_state.freezed.dart';

@freezed
sealed class PersonState with _$PersonState {
  const factory PersonState.initial() = PersonInitial;
  const factory PersonState.loading() = PersonLoading;
  const factory PersonState.success() = PersonSuccess;
  const factory PersonState.failure(String error) = PersonFailure;
}
