import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/person_registration/cubit/company_edit_state.dart';

class CompanyEditCubit extends Cubit<CompanyEditState> {
  final ICompanyRepository _repository;

  CompanyEditCubit(this._repository) : super(const CompanyEditInitial());

  Future<void> deleteCompany(int id) async {
    emit(const CompanyEditLoading());
    final result = await _repository.deleteCompany(id);

    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          emit(
            const CompanyEditDeleted('Pessoa jurídica excluída com sucesso.'),
          );
        } else {
          emit(
            const CompanyEditError(
              'Não foi possível excluir a pessoa jurídica.',
            ),
          );
        }
      case ResultError(:final resultError):
        emit(CompanyEditError(resultError));
    }
  }

  Future<void> updateCompany(Company company) async {
    emit(const CompanyEditLoading());
    final result = await _repository.updateCompany(company);

    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          emit(
            const CompanyEditSaved('Pessoa jurídica atualizada com sucesso.'),
          );
        } else {
          emit(
            const CompanyEditError(
              'Não foi possível atualizar a pessoa jurídica.',
            ),
          );
        }
      case ResultError(:final resultError):
        emit(CompanyEditError(resultError));
    }
  }
}
