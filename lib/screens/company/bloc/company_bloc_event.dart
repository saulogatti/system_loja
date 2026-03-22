part of 'company_bloc.dart';

@freezed
sealed class CompanyBlocEvent with _$CompanyBlocEvent {
  /// Evento para carregar todas as empresas
  const factory CompanyBlocEvent.loadCompanies() = _LoadCompanies;

  /// Evento para registrar uma nova empresa
  const factory CompanyBlocEvent.registerCompany({
    required String corporateName,
    required String cnpj,
    required String email,
    required String street,
    required String zipCode,
    required String neighborhood,
    required String city,
    required String state,
  }) = _RegisterCompany;

  /// Evento para deletar uma empresa
  const factory CompanyBlocEvent.deleteCompany({required int id}) =
      _DeleteCompany;

  /// Evento para buscar uma empresa pelo CNPJ
  const factory CompanyBlocEvent.findCompanyByCnpj({required String cnpj}) =
      _FindCompanyByCnpj;

  /// Evento para atualizar uma empresa existente
  const factory CompanyBlocEvent.updateCompany({required Company company}) =
      _UpdateCompany;
}
