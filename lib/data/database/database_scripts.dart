/// Scripts de criação das tabelas do banco de dados
///
/// Contém os scripts SQL para criação de todas as tabelas
/// necessárias para o funcionamento do sistema.
library;

import 'database_config.dart';

/// Classe contendo os scripts SQL de criação das tabelas
///
/// Agrupa todos os scripts DDL (Data Definition Language) necessários
/// para criar a estrutura do banco de dados.
class DatabaseScripts {
  /// Construtor privado para evitar instanciação
  DatabaseScripts._();

  /// Script de criação da tabela de clientes
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - nome: Nome completo do cliente (obrigatório)
  /// - cpf: CPF do cliente (único, obrigatório)
  /// - email: Endereço de email
  /// - telefone: Número de telefone
  /// - endereco: Endereço completo
  /// - data_cadastro: Data e hora do cadastro
  static String get createTableClientes => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableClientes} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      cpf TEXT NOT NULL UNIQUE,
      email TEXT,
      telefone TEXT,
      endereco TEXT,
      data_cadastro TEXT NOT NULL
    )
  ''';

  /// Script de criação da tabela de produtos
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - nome: Nome do produto (obrigatório)
  /// - codigo: Código do produto (único, obrigatório)
  /// - preco: Preço unitário do produto
  /// - estoque: Quantidade em estoque
  /// - descricao: Descrição detalhada do produto
  /// - categoria: Categoria do produto
  /// - data_cadastro: Data e hora do cadastro
  static String get createTableProdutos => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableProdutos} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      codigo TEXT NOT NULL UNIQUE,
      preco REAL NOT NULL,
      estoque INTEGER NOT NULL,
      descricao TEXT,
      categoria TEXT,
      data_cadastro TEXT NOT NULL
    )
  ''';

  /// Script de criação da tabela de notas fiscais
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - numero_nota: Número da nota fiscal (único, obrigatório)
  /// - cliente_id: Referência ao cliente
  /// - valor_total: Valor total da nota fiscal
  /// - forma_pagamento: Forma de pagamento utilizada
  /// - data_emissao: Data e hora de emissão da nota
  static String get createTableNotasFiscais => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableNotasFiscais} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      numero_nota TEXT NOT NULL UNIQUE,
      cliente_id INTEGER NOT NULL,
      valor_total REAL NOT NULL,
      forma_pagamento TEXT NOT NULL,
      data_emissao TEXT NOT NULL,
      FOREIGN KEY (cliente_id) REFERENCES ${DatabaseConfig.tableClientes}(id)
    )
  ''';

  /// Script de criação da tabela de itens de nota fiscal
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - nota_fiscal_id: Referência à nota fiscal
  /// - produto_id: Referência ao produto
  /// - quantidade: Quantidade do item
  /// - preco_unitario: Preço unitário do produto
  /// - valor_total: Valor total do item
  static String get createTableItensNotaFiscal => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableItensNotaFiscal} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nota_fiscal_id INTEGER NOT NULL,
      produto_id INTEGER NOT NULL,
      quantidade INTEGER NOT NULL,
      preco_unitario REAL NOT NULL,
      valor_total REAL NOT NULL,
      FOREIGN KEY (nota_fiscal_id) REFERENCES ${DatabaseConfig.tableNotasFiscais}(id) ON DELETE CASCADE,
      FOREIGN KEY (produto_id) REFERENCES ${DatabaseConfig.tableProdutos}(id)
    )
  ''';

  /// Script de criação da tabela de usuários
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - nome: Nome completo do usuário (obrigatório)
  /// - email: Email do usuário (único, obrigatório)
  /// - senha_hash: Hash SHA-256 da senha (obrigatório)
  /// - nivel_permissao: Nível de permissão do usuário (obrigatório)
  /// - data_cadastro: Data e hora do cadastro
  /// - data_ultima_atualizacao: Data e hora da última atualização
  static String get createTableUsuarios => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableUsuarios} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha_hash TEXT NOT NULL,
      nivel_permissao TEXT NOT NULL,
      data_cadastro TEXT NOT NULL,
      data_ultima_atualizacao TEXT NOT NULL
    )
  ''';

  /// Script de criação da tabela de logs de atividade
  ///
  /// Campos:
  /// - id: Identificador único auto-incrementado
  /// - tipo_acao: Tipo de ação realizada (CRIAR, LER, ATUALIZAR, DELETAR)
  /// - entidade: Nome da entidade afetada
  /// - entidade_id: ID da entidade afetada (pode ser nulo)
  /// - usuario_id: ID do usuário que realizou a ação
  /// - usuario_nome: Nome do usuário que realizou a ação
  /// - data_hora: Data e hora da ação
  /// - detalhes: Detalhes adicionais sobre a ação
  static String get createTableLogsAtividade => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableLogsAtividade} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tipo_acao TEXT NOT NULL,
      entidade TEXT NOT NULL,
      entidade_id INTEGER,
      usuario_id INTEGER NOT NULL,
      usuario_nome TEXT NOT NULL,
      data_hora TEXT NOT NULL,
      detalhes TEXT,
      FOREIGN KEY (usuario_id) REFERENCES ${DatabaseConfig.tableUsuarios}(id)
    )
  ''';

  /// Retorna todos os scripts de criação de tabelas na ordem correta
  ///
  /// A ordem é importante para respeitar as dependências entre tabelas.
  static List<String> get allCreateTableScripts => [
    createTableClientes,
    createTableProdutos,
    createTableNotasFiscais,
    createTableItensNotaFiscal,
    createTableUsuarios,
    createTableLogsAtividade,
  ];

  /// Script para criar índice no CPF do cliente
  static String get createIndexClienteCpf => '''
    CREATE INDEX IF NOT EXISTS idx_cliente_cpf ON ${DatabaseConfig.tableClientes}(cpf)
  ''';

  /// Script para criar índice no código do produto
  static String get createIndexProdutoCodigo => '''
    CREATE INDEX IF NOT EXISTS idx_produto_codigo ON ${DatabaseConfig.tableProdutos}(codigo)
  ''';

  /// Script para criar índice no número da nota fiscal
  static String get createIndexNotaFiscalNumero => '''
    CREATE INDEX IF NOT EXISTS idx_nota_fiscal_numero ON ${DatabaseConfig.tableNotasFiscais}(numero_nota)
  ''';

  /// Script para criar índice no email do usuário
  static String get createIndexUsuarioEmail => '''
    CREATE INDEX IF NOT EXISTS idx_usuario_email ON ${DatabaseConfig.tableUsuarios}(email)
  ''';

  /// Script para criar índice no usuário_id dos logs
  static String get createIndexLogUsuario => '''
    CREATE INDEX IF NOT EXISTS idx_log_usuario ON ${DatabaseConfig.tableLogsAtividade}(usuario_id)
  ''';

  /// Script para criar índice na entidade dos logs
  static String get createIndexLogEntidade => '''
    CREATE INDEX IF NOT EXISTS idx_log_entidade ON ${DatabaseConfig.tableLogsAtividade}(entidade, entidade_id)
  ''';

  /// Retorna todos os scripts de criação de índices
  static List<String> get allCreateIndexScripts => [
    createIndexClienteCpf,
    createIndexProdutoCodigo,
    createIndexNotaFiscalNumero,
    createIndexUsuarioEmail,
    createIndexLogUsuario,
    createIndexLogEntidade,
  ];
}
