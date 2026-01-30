import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/repository/company_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

part 'company_bloc.freezed.dart';
part 'company_bloc_event.dart';
part 'company_bloc_state.dart';

/// BLoC para gerenciamento de estado de empresas
///
/// Utiliza o CompanyRepository para operações de banco de dados
/// e implementa o padrão BLoC para separação de lógica de negócio da UI.
class CompanyBloc extends Bloc<CompanyBlocEvent, CompanyBlocState> {
  final CompanyRepository _companyRepository = CompanyRepository();

  CompanyBloc() : super(const _Initial()) {
    on<_LoadCompanies>(_onLoadCompanies);
    on<_RegisterCompany>(_onRegisterCompany);
    on<_DeleteCompany>(_onDeleteCompany);
    on<_FindCompanyByCnpj>(_onFindCompanyByCnpj);
    on<_UpdateCompany>(_onUpdateCompany);
  }

  /// Deleta uma empresa pelo ID
  FutureOr<void> _onDeleteCompany(
    _DeleteCompany event,
    Emitter<CompanyBlocState> emit,
  ) async {
    emit(const CompanyBlocState.loading());
    final result = await _companyRepository.deleteCompany(event.id);
    
    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          // Recarrega a lista de empresas após deletar
          final companies = await _companyRepository.fetchMappedCompanies();
          if (companies is ResultSuccess) {
            emit(
              CompanyBlocState.companiesLoaded(
                companies: companies.asSuccess,
                stateType: EnumStateCompanyLoaded.deleteCompany,
              ),
            );
          } else if (companies is ResultError) {
            emit(
              CompanyBlocState.companyError(
                message:
                    'Erro ao carregar empresas após deleção: ${companies.asError}',
              ),
            );
          }
        }
      case ResultError<bool, String>(:final resultError):
        emit(
          CompanyBlocState.companyError(
            message: 'Erro ao deletar empresa: $resultError',
          ),
        );
    }
  }

  /// Busca uma empresa pelo CNPJ
  FutureOr<void> _onFindCompanyByCnpj(
    _FindCompanyByCnpj event,
    Emitter<CompanyBlocState> emit,
  ) async {
    emit(const CompanyBlocState.loading());
    final result = await _companyRepository.findByCnpj(cnpj: event.cnpj);
    result.when(
      onSuccess: (company) {
        if (company == null) {
          emit(
            CompanyBlocState.companyError(
              message: 'Empresa com CNPJ ${event.cnpj} não encontrada.',
            ),
          );
          return;
        }
        emit(CompanyBlocState.companyFound(company: company));
      },
      onError: (error) {
        emit(
          CompanyBlocState.companyError(
            message: 'Erro ao buscar empresa: $error',
          ),
        );
      },
    );
  }

  /// Carrega todas as empresas do banco de dados
  Future<void> _onLoadCompanies(
    _LoadCompanies event,
    Emitter<CompanyBlocState> emit,
  ) async {
    emit(const CompanyBlocState.loading());
    final result = await _companyRepository.fetchMappedCompanies();
    result.when(
      onSuccess: (companies) {
        emit(
          CompanyBlocState.companiesLoaded(
            companies: companies,
            stateType: EnumStateCompanyLoaded.companiesLoaded,
          ),
        );
      },
      onError: (error) {
        emit(
          CompanyBlocState.companyError(
            message: 'Erro ao carregar empresas: $error',
          ),
        );
      },
    );
  }

  /// Registra uma nova empresa no banco de dados
  ///
  /// O ID é definido como 0 pois a tabela usa AUTOINCREMENT.
  /// O banco de dados SQLite gerará automaticamente o próximo ID disponível.
  Future<void> _onRegisterCompany(
    _RegisterCompany event,
    Emitter<CompanyBlocState> emit,
  ) async {
    emit(const CompanyBlocState.loading());

    // Validação de email
    if (event.email.isNotEmpty && !event.email.isValidEmail()) {
      emit(
        const CompanyBlocState.companyError(message: 'Erro: Email inválido!'),
      );
      return;
    }

    final result = await _companyRepository.saveCompany(
      Company(
        id: 0,
        corporateName: event.corporateName,
        cnpj: event.cnpj,
        email: event.email,
        street: event.street,
        zipCode: event.zipCode,
        neighborhood: event.neighborhood,
        city: event.city,
      ),
    );

    result.when(
      onSuccess: (_) async {
        // Recarrega a lista de empresas após adicionar
        final companies = await _companyRepository.fetchMappedCompanies();

        emit(
          CompanyBlocState.companiesLoaded(
            companies: companies.asSuccess,
            stateType: EnumStateCompanyLoaded.registerCompany,
          ),
        );
      },
      onError: (error) {
        emit(CompanyBlocState.companyError(message: error));
        return;
      },
    );
  }

  /// Atualiza uma empresa existente no banco de dados
  FutureOr<void> _onUpdateCompany(
    _UpdateCompany event,
    Emitter<CompanyBlocState> emit,
  ) async {
    emit(const CompanyBlocState.loading());

    final resultUpdate = await _companyRepository.updateCompany(
      event.company,
    );
    switch (resultUpdate) {
      case ResultSuccess(:final result):
        if (!result) {
          emit(
            CompanyBlocState.companyError(
              message: 'Erro ao atualizar empresa: Empresa não encontrada.',
            ),
          );
          return;
        }

        // Recarrega a lista de empresas após atualizar
        final resultFetch = await _companyRepository.fetchMappedCompanies();
        switch (resultFetch) {
          case ResultSuccess(:final result):
            emit(
              CompanyBlocState.companiesLoaded(
                companies: result,
                stateType: EnumStateCompanyLoaded.updateCompany,
              ),
            );
          case ResultError(:final resultError):
            emit(
              CompanyBlocState.companyError(
                message:
                    'Erro ao carregar empresas após atualização: $resultError',
              ),
            );
        }

      case ResultError<bool, String>(:final resultError):
        emit(
          CompanyBlocState.companyError(
            message: 'Erro ao atualizar empresa: $resultError',
          ),
        );
        return;
    }
  }
}
