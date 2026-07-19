import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/screens/person_registration/cubit/customer_edit_state.dart';

class CustomerEditCubit extends Cubit<CustomerEditState> {

  CustomerEditCubit(this._repository) : super(const CustomerEditInitial());
  final ICustomerRepository _repository;

  Future<void> deleteCustomer(int id) async {
    emit(const CustomerEditLoading());
    final result = await _repository.deleteClient(id);

    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          emit(
            const CustomerEditDeleted('Pessoa física excluída com sucesso.'),
          );
        } else {
          emit(
            const CustomerEditError(
              'Não foi possível excluir a pessoa física.',
            ),
          );
        }
      case ResultError(:final resultError):
        emit(CustomerEditError(resultError));
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    emit(const CustomerEditLoading());
    final result = await _repository.updateCustomer(customer);

    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          emit(
            const CustomerEditSaved('Pessoa física atualizada com sucesso.'),
          );
        } else {
          emit(
            const CustomerEditError(
              'Não foi possível atualizar a pessoa física.',
            ),
          );
        }
      case ResultError(:final resultError):
        emit(CustomerEditError(resultError));
    }
  }
}
