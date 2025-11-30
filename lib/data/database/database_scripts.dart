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
  /// - cliente_nome: Nome do cliente (desnormalizado para consultas)
  /// - cliente_cpf: CPF do cliente (desnormalizado para consultas)
  /// - valor_total: Valor total da nota fiscal
  /// - forma_pagamento: Forma de pagamento utilizada
  /// - data_emissao: Data e hora de emissão da nota
  static String get createTableNotasFiscais => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableNotasFiscais} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      numero_nota TEXT NOT NULL UNIQUE,
      cliente_id INTEGER NOT NULL,
      cliente_nome TEXT NOT NULL,
      cliente_cpf TEXT NOT NULL,
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
  /// - produto_nome: Nome do produto (desnormalizado)
  /// - produto_codigo: Código do produto (desnormalizado)
  /// - quantidade: Quantidade do item
  /// - preco_unitario: Preço unitário do produto
  /// - valor_total: Valor total do item
  static String get createTableItensNotaFiscal => '''
    CREATE TABLE IF NOT EXISTS ${DatabaseConfig.tableItensNotaFiscal} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nota_fiscal_id INTEGER NOT NULL,
      produto_id INTEGER NOT NULL,
      produto_nome TEXT NOT NULL,
      produto_codigo TEXT NOT NULL,
      quantidade INTEGER NOT NULL,
      preco_unitario REAL NOT NULL,
      valor_total REAL NOT NULL,
      FOREIGN KEY (nota_fiscal_id) REFERENCES ${DatabaseConfig.tableNotasFiscais}(id) ON DELETE CASCADE,
      FOREIGN KEY (produto_id) REFERENCES ${DatabaseConfig.tableProdutos}(id)
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

  /// Retorna todos os scripts de criação de índices
  static List<String> get allCreateIndexScripts => [
    createIndexClienteCpf,
    createIndexProdutoCodigo,
    createIndexNotaFiscalNumero,
  ];
}
