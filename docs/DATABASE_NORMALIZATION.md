# Normalização do Banco de Dados SQL

## Problema Identificado

Nas versões anteriores do banco de dados (v1), as tabelas `notas_fiscais` e `itens_nota_fiscal` continham campos desnormalizados:

- **Tabela `notas_fiscais`**: `cliente_nome`, `cliente_cpf`
- **Tabela `itens_nota_fiscal`**: `produto_nome`, `produto_codigo`

### Risco de Inconsistência

Esses campos desnormalizados introduziam um risco de inconsistência de dados:

1. Se o nome ou CPF de um cliente fosse atualizado através do `ClienteSqlManager`, as notas fiscais existentes para esse cliente ficariam com dados desatualizados.
2. Se o nome ou código de um produto fosse atualizado através do `ProdutoSqlManager`, os itens das notas fiscais existentes ficariam com dados desatualizados.

## Solução Implementada

### Versão 2 do Banco de Dados

Na versão 2, foram removidos os campos desnormalizados e implementadas consultas com JOIN para garantir integridade dos dados.

#### Alterações no Schema

**Tabela `notas_fiscais` (v2)**
```sql
CREATE TABLE notas_fiscais (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  numero_nota TEXT NOT NULL UNIQUE,
  cliente_id INTEGER NOT NULL,              -- Mantido
  -- cliente_nome TEXT NOT NULL,            -- REMOVIDO
  -- cliente_cpf TEXT NOT NULL,             -- REMOVIDO
  valor_total REAL NOT NULL,
  forma_pagamento TEXT NOT NULL,
  data_emissao TEXT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
)
```

**Tabela `itens_nota_fiscal` (v2)**
```sql
CREATE TABLE itens_nota_fiscal (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nota_fiscal_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,              -- Mantido
  -- produto_nome TEXT NOT NULL,            -- REMOVIDO
  -- produto_codigo TEXT NOT NULL,          -- REMOVIDO
  quantidade INTEGER NOT NULL,
  preco_unitario REAL NOT NULL,
  valor_total REAL NOT NULL,
  FOREIGN KEY (nota_fiscal_id) REFERENCES notas_fiscais(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id)
)
```

#### Uso de JOINs

Todas as consultas de notas fiscais agora utilizam JOINs para buscar os dados atualizados de clientes e produtos:

```sql
-- Exemplo de consulta de nota fiscal
SELECT 
  nf.*, 
  c.nome as cliente_nome, 
  c.cpf as cliente_cpf
FROM notas_fiscais nf
INNER JOIN clientes c ON nf.cliente_id = c.id
WHERE nf.id = ?

-- Exemplo de consulta de itens da nota fiscal
SELECT 
  i.*, 
  p.nome as produto_nome, 
  p.codigo as produto_codigo
FROM itens_nota_fiscal i
INNER JOIN produtos p ON i.produto_id = p.id
WHERE i.nota_fiscal_id = ?
```

### Migração Automática

O sistema implementa migração automática de dados da versão 1 para a versão 2:

1. Cria tabelas temporárias com a nova estrutura (sem campos desnormalizados)
2. Copia os dados relevantes das tabelas antigas
3. Exclui as tabelas antigas
4. Renomeia as tabelas temporárias

A migração é executada automaticamente quando o banco é aberto e a versão é detectada como anterior a 2.

## Benefícios

### 1. Integridade de Dados

Agora, quando um cliente ou produto é atualizado, todas as notas fiscais refletirão automaticamente os dados atualizados através dos JOINs.

### 2. Consistência Garantida

Não há mais risco de dados desatualizados nas notas fiscais, pois os dados são sempre buscados das tabelas originais.

### 3. Manutenção Simplificada

Não é necessário implementar lógica complexa para propagar atualizações de clientes e produtos para todas as notas fiscais relacionadas.

### 4. Padrão de Banco de Dados

A solução segue as melhores práticas de normalização de banco de dados, mantendo as chaves estrangeiras e usando JOINs para relacionamentos.

## Testes de Integridade

Foram implementados testes abrangentes em `test/data_integrity_test.dart` que validam:

1. Alterações no nome do cliente são refletidas nas notas fiscais
2. Alterações no CPF do cliente são refletidas nas notas fiscais
3. Alterações no nome do produto são refletidas nos itens das notas fiscais
4. Alterações no código do produto são refletidas nos itens das notas fiscais
5. Dados atualizados são consistentes em todas as formas de consulta (por ID, número, cliente, período, lista completa)

## Impacto em Sistemas Existentes

### Compatibilidade com Modelos

Os modelos de dados (`NotaFiscal`, `ItemNotaFiscal`) mantêm os campos desnormalizados para compatibilidade com a persistência JSON. O `NotaFiscalSqlManager` popula esses campos dinamicamente através dos JOINs.

### Sem Impacto na UI

As telas e componentes de UI não precisam ser alterados, pois continuam recebendo objetos `NotaFiscal` completos com todos os campos populados.

### Migração Transparente

Usuários existentes terão seus bancos de dados migrados automaticamente na próxima inicialização do aplicativo, sem perda de dados.

## Referências

- [GitHub Issue #11 - Discussion r2573166765](https://github.com/saulogatti/system_loja/pull/11#discussion_r2573166765)
- Implementação: `lib/data/database/database_scripts.dart`
- Migração: `lib/data/database/database_helper.dart`
- Manager: `lib/data/database/nota_fiscal_sql_manager.dart`
- Testes: `test/data_integrity_test.dart`
