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
    final result = await _systemRepository.getSystemConfiguration();
    switch (result) {
      case ResultSuccess(:final result):
        emit(HomeLoaded(result.systemUserData));
      case ResultError(:final resultError):
        emit(HomeError(resultError));
    }
  }

  FutureOr<void> _onSaveSystemUserData(
    SaveSystemUserData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final loadResult = await _systemRepository.getSystemConfiguration();
    switch (loadResult) {
      case ResultSuccess(:final result):
        final systemConfiguration = result;
        systemConfiguration.systemUserData = event.systemUserData;
        final saveResult = await _systemRepository.saveSystemConfiguration(
          systemConfiguration,
        );
        switch (saveResult) {
          case ResultSuccess():
            emit(HomeSaved(systemConfiguration.systemUserData));
          case ResultError(:final resultError):
            emit(HomeError(resultError));
        }
      case ResultError(:final resultError):
        emit(HomeError(resultError));
    }
  }
}
