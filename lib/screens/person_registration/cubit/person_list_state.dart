import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';

class PersonListLoaded extends PersonListState {
  final List<Customer> customers;
  final List<Company> companies;
  final String? errorMessage;

  const PersonListLoaded({
    required this.customers,
    required this.companies,
    this.errorMessage,
  });
}

class PersonListLoading extends PersonListState {
  const PersonListLoading();
}

sealed class PersonListState {
  const PersonListState();
}