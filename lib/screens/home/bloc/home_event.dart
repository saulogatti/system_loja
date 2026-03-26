part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadSystemUserData() = LoadSystemUserData;
  const factory HomeEvent.saveSystemUserData(SystemUserData systemUserData) = SaveSystemUserData;
}
