import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/result_status.dart';

import 'package:system_loja/screens/person_registration/cubit/person_list_state.dart';

/// Cubit responsável por carregar e expor a listagem de pessoas físicas e jurídicas.
class PersonListCubit extends Cubit<PersonListState> {

  PersonListCubit(this._customerRepository, this._companyRepository)
    : super(const PersonListInitial());
  final ICustomerRepository _customerRepository;
  final ICompanyRepository _companyRepository;

  Future<void> loadPeople() async {
    emit(const PersonListLoading());

    final customerResult = await _customerRepository.getAllCustomers();
    final companyResult = await _companyRepository.getAllCompanies();

    final errors = <String>[];
    final List<Customer> customers;
    switch (customerResult) {
      case ResultSuccess(: final result):
        customers = result;
      case ResultError(resultError: final error):
        customers = const <Customer>[];
        errors.add(error);
    }

    final List<Company> companies;
    switch (companyResult) {
      case ResultSuccess(: final result):
        companies = result;
      case ResultError(resultError: final error):
        companies = const <Company>[];
        errors.add(error);
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
