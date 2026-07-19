import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';

class PersonListInitial extends PersonListState {
  const PersonListInitial();
}

class PersonListLoaded extends PersonListState {

  const PersonListLoaded({
    required this.customers,
    required this.companies,
    this.errorMessage,
  });
  final List<Customer> customers;
  final List<Company> companies;
  final String? errorMessage;
}

class PersonListLoading extends PersonListState {
  const PersonListLoading();
}

sealed class PersonListState {
  const PersonListState();
}
