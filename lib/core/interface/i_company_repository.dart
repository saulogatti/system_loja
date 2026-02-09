import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de repositório de empresas.
///
/// Esta interface abstrai as operações CRUD (Create, Read, Update, Delete)
/// para entidades [Company], permitindo diferentes implementações de
/// persistência (Drift, JSON, etc.).
///
/// As operações incluem busca por CNPJ, mapeamento de empresas por ID,
/// e gerenciamento completo do cadastro de empresas.
///
/// Exemplo de uso:
/// ```dart
/// final repository = AppInjection.instance.companyRepository;
/// final resultado = await repository.findByCnpj(cnpj: '12345678000199');
/// if (resultado.isSuccessful && resultado.asSuccess != null) {
///   final company = resultado.asSuccess!;
///   print('Empresa: ${company.fantasyName}');
/// }
/// ```
///
/// Veja também:
/// - [Company] - modelo de domínio de empresa
/// - [ResultStatus] - tipo de retorno para operações
abstract interface class ICompanyRepository {
  /// Remove uma empresa do sistema pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único da empresa a ser removida
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removida com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> deleteCompany(int id);

  /// Retorna todas as empresas mapeadas por ID.
  ///
  /// Útil para acesso rápido a empresas por ID sem necessidade de busca.
  ///
  /// Retorna:
  /// - [ResultStatus] com Map<int, Company> ou mensagem de erro
  Future<ResultStatus<Map<int, Company>, String>> fetchMappedCompanies();

  /// Busca uma empresa pelo CNPJ.
  ///
  /// Útil para validação e verificação de duplicidade de CNPJ.
  ///
  /// Parâmetros:
  /// - [cnpj]: CNPJ da empresa no formato com ou sem formatação
  ///
  /// Retorna:
  /// - [ResultStatus] com a empresa encontrada (ou null) ou mensagem de erro
  Future<ResultStatus<Company?, String>> findByCnpj({required String cnpj});

  /// Busca uma empresa específica pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único da empresa
  ///
  /// Retorna:
  /// - [ResultStatus] com a empresa encontrada (ou null) ou mensagem de erro
  Future<ResultStatus<Company?, String>> findCompanyById(int id);

  /// Retorna todas as empresas cadastradas no sistema.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de empresas ou mensagem de erro
  Future<ResultStatus<List<Company>, String>> getAllCompanies();

  /// Salva uma nova empresa no sistema.
  ///
  /// Para empresas sem ID ou com ID = 0, será criado um novo registro.
  ///
  /// Parâmetros:
  /// - [company]: Objeto Company a ser salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com true se salva com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> saveCompany(Company company);

  /// Atualiza os dados de uma empresa existente.
  ///
  /// A empresa deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [company]: Objeto Company com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizada com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateCompany(Company company);
}
