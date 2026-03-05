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
  }

  Future<void> _onLoadSystemUserData(LoadSystemUserData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final systemConfiguration = await _systemRepository.getSystemConfiguration();
    if (systemConfiguration == null) {
      emit(const HomeError('Sistema não configurado'));
      return;
    }
    emit(HomeLoaded(systemConfiguration.systemUserData));
  }
}
