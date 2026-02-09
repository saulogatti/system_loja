import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class ICompanyRepository {
  Future<ResultStatus<bool, String>> deleteCompany(int id);
  Future<ResultStatus<Map<int, Company>, String>> fetchMappedCompanies();
  Future<ResultStatus<Company?, String>> findByCnpj({required String cnpj});
  Future<ResultStatus<Company?, String>> findCompanyById(int id);
  Future<ResultStatus<List<Company>, String>> getAllCompanies();
  Future<ResultStatus<bool, String>> saveCompany(Company company);
  Future<ResultStatus<bool, String>> updateCompany(Company company);
}
