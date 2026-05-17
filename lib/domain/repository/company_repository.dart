import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/aplication/system_error_manager.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/company_dao.dart';

/// Repository para gerenciar operações de empresas.
///
/// Utiliza CompanyDao para acesso ao banco de dados e gerencia
/// logs de atividades do sistema.
class CompanyRepository implements ICompanyRepository {
  final ILogRepository _logRepository;
  final CompanyDao dao;

  CompanyRepository({
    required ILogRepository logRepository,
    required CompanyDao companyDao,
  }) : _logRepository = logRepository,
       dao = companyDao;

  /// Deleta uma empresa pelo ID.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  @override
  Future<ResultStatus<bool, String>> deleteCompany(int id) async {
    try {
      final company = await dao.getById(id);
      if (company == null) {
        return ResultStatus.error('Empresa com ID $id não encontrada.');
      }

      await dao.deleteCompany(id);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.deletar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Deleted company with ID $id',
      );

      return ResultStatus.success(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao deletar empresa.');
    }
  }

  /// Busca todas as empresas mapeadas por ID.
  ///
  /// Retorna [ResultStatus] com Map de empresas ou mensagem de erro.
  @override
  Future<ResultStatus<Map<int, Company>, String>> fetchMappedCompanies() async {
    try {
      final data = await dao.getAll();
      final companies = data;
      final mappedCompanies = {
        for (var company in companies) company.id: company,
      };
      return ResultStatus.success(mappedCompanies);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar empresas mapeadas.');
    }
  }

  /// Busca uma empresa pelo CNPJ.
  ///
  /// Retorna [ResultStatus] com a empresa encontrada ou mensagem de erro.
  @override
  Future<ResultStatus<Company?, String>> findByCnpj({
    required String cnpj,
  }) async {
    try {
      final company = await dao.getByCnpj(cnpj);
      return ResultStatus.success(company);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar empresa por CNPJ.');
    }
  }

  /// Busca uma empresa específica pelo ID.
  ///
  /// Retorna [ResultStatus] com a empresa encontrada ou mensagem de erro.
  @override
  Future<ResultStatus<Company?, String>> findCompanyById(int id) async {
    try {
      final data = await dao.getById(id);
      return ResultStatus.success(data);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar empresa por ID.');
    }
  }

  /// Obtém todas as empresas.
  ///
  /// Retorna [ResultStatus] com lista de empresas ou mensagem de erro.
  @override
  Future<ResultStatus<List<Company>, String>> getAllCompanies() async {
    try {
      final data = await dao.getAll();
      return ResultStatus.success(data);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar todas as empresas.');
    }
  }

  /// Salva uma nova empresa.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  @override
  Future<ResultStatus<bool, String>> saveCompany(Company company) async {
    try {
      // Verifica se já existe empresa com o mesmo CNPJ
      final existingCompany = await dao.getByCnpj(company.cnpj);
      if (existingCompany != null) {
        return ResultStatus.error(
          'Já existe uma empresa cadastrada com o CNPJ ${company.cnpj}.',
        );
      }

      await dao.addCompany(company);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.criar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Empresa ${company.name} (ID: ${company.id}) criada.',
      );

      return ResultStatus.success(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao salvar empresa.');
    }
  }

  /// Atualiza uma empresa existente.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  @override
  Future<ResultStatus<bool, String>> updateCompany(Company company) async {
    try {
      final exists = await dao.getById(company.id);
      if (exists == null) {
        return ResultStatus.error(
          'Empresa com ID ${company.id} não encontrada.',
        );
      }

      // Verifica se o CNPJ já existe em outra empresa
      final existingCompany = await dao.getByCnpj(company.cnpj);
      if (existingCompany != null && existingCompany.id != company.id) {
        return ResultStatus.error(
          'Já existe outra empresa cadastrada com o CNPJ ${company.cnpj}.',
        );
      }

      await dao.updateCompany(company);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.atualizar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Empresa ${company.name} (ID: ${company.id}) atualizada.',
      );

      return ResultStatus.success(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao atualizar empresa.');
    }
  }
}
