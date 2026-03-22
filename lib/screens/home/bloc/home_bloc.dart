import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

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
    result.when(
      onSuccess: (systemConfiguration) {
        emit(HomeLoaded(systemConfiguration.systemUserData));
      },
      onError: (message) {
        emit(HomeState.error(message));
      },
    );
  }

  FutureOr<void> _onSaveSystemUserData(
    SaveSystemUserData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final loadResult = await _systemRepository.getSystemConfiguration();
    if (loadResult.hasError) {
      emit(HomeState.error(loadResult.asError));
      return;
    }
    final systemConfiguration = loadResult.asSuccess;
    systemConfiguration.systemUserData = event.systemUserData;
    final saveResult = await _systemRepository.saveSystemConfiguration(
      systemConfiguration,
    );
    saveResult.when(
      onSuccess: (_) {
        emit(HomeSaved(systemConfiguration.systemUserData));
      },
      onError: (message) {
        emit(HomeState.error(message));
      },
    );
  }
}
