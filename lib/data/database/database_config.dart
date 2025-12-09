/// Configurações do banco de dados SQL
///
/// Define constantes e configurações utilizadas para conexão
/// e gerenciamento do banco de dados SQLite.
library;

/// Classe de configuração do banco de dados
///
/// Contém todas as constantes e configurações necessárias
/// para o funcionamento do banco de dados SQLite.
class DatabaseConfig {
  /// Nome do arquivo do banco de dados
  static const String databaseName = 'system_loja.db';

  /// Versão atual do banco de dados
  ///
  /// Incrementar este valor quando houver alterações no schema
  /// para disparar a migração automática.
  ///
  /// Versão 2: Removidos campos desnormalizados cliente_nome, cliente_cpf,
  /// produto_nome, produto_codigo para garantir integridade de dados.
  /// Versão 3: Adicionadas tabelas usuarios e logs_atividade para
  /// sistema de gestão de usuários e auditoria.
  /// Versão 4: Adicionada tabela persistent_data_store para armazenamento
  /// genérico de dados categorizados.
  static const int databaseVersion = 4;

  /// Nome da tabela de clientes
  static const String tableClientes = 'clientes';

  /// Nome da tabela de produtos
  static const String tableProdutos = 'produtos';

  /// Nome da tabela de notas fiscais
  static const String tableNotasFiscais = 'notas_fiscais';

  /// Nome da tabela de itens de notas fiscais
  static const String tableInvoiceItems = 'itens_nota_fiscal';

  /// Nome da tabela de usuários
  static const String tableUsuarios = 'usuarios';

  /// Nome da tabela de logs de atividade
  static const String tableLogsAtividade = 'logs_atividade';

  /// Nome da tabela de armazenamento persistente genérico
  static const String tablePersistentDataStore = 'persistent_data_store';

  /// Construtor privado para evitar instanciação
  DatabaseConfig._();
}
