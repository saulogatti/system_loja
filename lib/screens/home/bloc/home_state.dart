part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.error(String message) = HomeError;
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loaded(SystemUserData systemUserData) = HomeLoaded;
  const factory HomeState.loading() = HomeLoading;
}
