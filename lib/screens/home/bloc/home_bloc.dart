import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/core/utils/command_result.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ISystemRepository _systemRepository;
  HomeBloc(this._systemRepository) : super(const HomeInitial()) {
    on<LoadSystemUserData>(_onLoadSystemUserData);
    on<SaveSystemUserData>(_onSaveSystemUserData);
  }

  Future<void> _onLoadSystemUserData(
    LoadSystemUserData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final configurationResult = await _systemRepository
        .getSystemConfiguration();
    switch (configurationResult) {
      case ResultSuccess(result: final systemConfiguration):
        emit(HomeLoaded(systemConfiguration.systemUserData));
      case ResultError(resultError: final errorMessage):
        emit(HomeError(errorMessage));
    }
  }

  FutureOr<void> _onSaveSystemUserData(
    SaveSystemUserData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final configurationResult = await _systemRepository
        .getSystemConfiguration();
    switch (configurationResult) {
      case ResultSuccess(result: final systemConfiguration):
        systemConfiguration.systemUserData = event.systemUserData;
        final saveResult = await _systemRepository.saveSystemConfiguration(
          systemConfiguration,
        );
        switch (saveResult) {
          case ResultSuccess():
            emit(HomeSaved(systemConfiguration.systemUserData));
          case ResultError(resultError: final errorMessage):
            emit(HomeError(errorMessage));
        }
      case ResultError(resultError: final errorMessage):
        emit(HomeError(errorMessage));
    }
  }
}
