import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/person_registration/cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  final ICustomerRepository _customerRepository;
  final ICompanyRepository _companyRepository;

  PersonListCubit(this._customerRepository, this._companyRepository) : super(const PersonListLoading()) {
    reloadPeople();
  }

  Future<void> reloadPeople() async {
    emit(const PersonListLoading());

    final customerResult = await _customerRepository.getAllCustomers();
    final companyResult = await _companyRepository.getAllCompanies();

    final errors = <String>[];
    final customers = customerResult.isSuccessful ? customerResult.asSuccess : <Customer>[];
    final companies = companyResult.isSuccessful ? companyResult.asSuccess : <Company>[];

    if (customerResult.hasError) {
      errors.add(customerResult.asError);
    }
    if (companyResult.hasError) {
      errors.add(companyResult.asError);
    }

    emit(
      PersonListLoaded(
        customers: customers,
        companies: companies,
        errorMessage: errors.isEmpty ? null : errors.join(' | '),
      ),
    );
  }
}
