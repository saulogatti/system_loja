part of 'customer_bloc.dart';

@freezed
class CustomerBlocState with _$CustomerBlocState {
  const factory CustomerBlocState.customerAdded({required Customer customer}) =
      _CustomerAdded;

  const factory CustomerBlocState.customerError({required String message}) =
      _CustomerError;
  const factory CustomerBlocState.initial() = _Initial;
}
