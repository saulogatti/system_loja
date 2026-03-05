part of 'company_bloc.dart';

/// Tipos de estados após carregar empresas
enum EnumStateCompanyLoaded {
  companiesLoaded,
  registerCompany,
  deleteCompany,
  updateCompany,
}

@freezed
sealed class CompanyBlocState with _$CompanyBlocState {
  /// Estado inicial
  const factory CompanyBlocState.initial() = _Initial;

  /// Estado de carregamento
  const factory CompanyBlocState.loading() = _Loading;

  /// Estado quando empresas são carregadas com sucesso
  const factory CompanyBlocState.companiesLoaded({
    required Map<int, Company> companies,
    required EnumStateCompanyLoaded stateType,
  }) = _CompaniesLoaded;

  /// Estado quando uma empresa específica é encontrada
  const factory CompanyBlocState.companyFound({
    required Company company,
  }) = _CompanyFound;

  /// Estado de erro
  const factory CompanyBlocState.companyError({
    required String message,
  }) = _CompanyError;
}
