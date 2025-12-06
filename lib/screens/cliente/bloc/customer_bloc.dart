import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/managers/customer_manager.dart';
import 'package:system_loja/core/managers/exceptions/cliente_exception.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/resultado.dart';

part 'customer_bloc.freezed.dart';
part 'customer_bloc_event.dart';
part 'customer_bloc_state.dart';

class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  CustomerBloc() : super(_Initial()) {
    on<CustomerBlocEvent>((event, emit) async {
      switch (event) {
        case _RegisterCustomer():
          CustomerInfo customerInfo = CustomerInfo(
            name: event.name,
            cpf: event.cpf,
            email: event.email,
            phone: event.phone,
            address: event.address,
          );

          CustomerServiceManager customerManager = CustomerServiceManager();
          OperationResult<Customer, CustomerException> operationResult =
              await customerManager.addNewCustomer(customerInfo: customerInfo);
          switch (operationResult) {
            case OperationSuccess(result: final customer):
              emit(CustomerBlocState.customerAdded(customer: customer));
            case OperationError(error: final erro):
              emit(CustomerBlocState.customerError(message: erro.message));
          }
      }
    });
  }
}
