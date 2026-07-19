import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/screens/person_registration/bloc/person_event.dart';
import 'package:system_loja/screens/person_registration/bloc/person_state.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc(this._customerRepository, this._companyRepository)
    : super(const PersonState.initial()) {
    on<PersonSubmit>(_onSubmit);
  }
  final ICustomerRepository _customerRepository;
  final ICompanyRepository _companyRepository;

  FutureOr<void> _onSubmit(
    PersonSubmit event,
    Emitter<PersonState> emit,
  ) async {
    emit(const PersonState.loading());
    final data = event.formData;

    if (data.personType == PersonType.individual) {
      // Validações específicas para pessoa física
      if (data.document.length != 11) {
        emit(const PersonState.failure('CPF deve conter 11 dígitos'));
        return;
      }

      final result = await _customerRepository.saveCustomer(
        data.retrieveCustomer(),
      );
      switch (result) {
        case ResultSuccess(:final result):
          if (result) {
            emit(const PersonState.success());
          } else {
            emit(const PersonState.failure('Erro ao salvar cliente.'));
          }
        case ResultError(:final resultError):
          emit(PersonState.failure(resultError));
          return;
      }
    } else {
      // Validações específicas para pessoa jurídica
      if (data.document.length != 14) {
        emit(const PersonState.failure('CNPJ deve conter 14 dígitos'));
        return;
      }

      final result = await _companyRepository.saveCompany(
        data.retrieveCompany(),
      );
      switch (result) {
        case ResultSuccess(:final result):
          if (result) {
            emit(const PersonState.success());
          } else {
            emit(const PersonState.failure('Erro ao salvar empresa.'));
          }
        case ResultError(:final resultError):
          emit(PersonState.failure(resultError));
          return;
      }
    }
  }
}
