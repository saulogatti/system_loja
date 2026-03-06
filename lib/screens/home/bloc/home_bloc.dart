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

  Future<void> _onLoadSystemUserData(LoadSystemUserData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final systemConfiguration = await _systemRepository.getSystemConfiguration();
    emit(HomeLoaded(systemConfiguration.systemUserData));
  }

  FutureOr<void> _onSaveSystemUserData(SaveSystemUserData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final systemConfiguration = await _systemRepository.getSystemConfiguration();
    systemConfiguration.systemUserData = event.systemUserData;
    await _systemRepository.saveSystemConfiguration(systemConfiguration);
    emit(HomeSaved(systemConfiguration.systemUserData));
  }
}
