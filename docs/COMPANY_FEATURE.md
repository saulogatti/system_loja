# Feature: Cadastro de Empresas

## Visao Geral

Esta funcionalidade cobre o ciclo de cadastro, listagem, busca por CNPJ, atualizacao e remocao de empresas, seguindo o fluxo oficial do projeto:

Screen -> Interface -> Repository -> DAO Drift -> SQLite.

## Regras de Negocio

- CNPJ deve ser unico no banco.
- CNPJ e normalizado para comparacao/armazenamento (somente digitos).
- Operacoes de repositorio retornam `ResultStatus<R, E>` com mensagens amigaveis.

## Arquitetura Atual

### Dominio/Core

- Modelo: `lib/core/models/company.dart`
- Contrato: `lib/core/interface/i_company_repository.dart`

### Dados (Drift)

- Tabela: `lib/data/database/table/company_records.dart`
- DAO: `lib/data/database/dao/company_dao.dart`
- Conversao para companion: `lib/data/database/extension/company_to_companion.dart`

### Repositorio

- Implementacao: `lib/domain/repository/company_repository.dart`
- Registro em DI: `setupAppInjection()` em `lib/application/app_injection.dart`

### Apresentacao

- Tela principal: `lib/screens/company/company_view.dart`
- Bloc e estados: `lib/screens/company/bloc/`
- Widgets: `lib/screens/company/widgets/`

## Banco de Dados

- Banco principal: `AppDatabase`
- Versao atual do schema: `12`
- A tabela de empresas e registrada no `@DriftDatabase` do `AppDatabase`.

## Geracao e Validacao

Sempre que houver alteracao de modelos Freezed/JSON, DAOs/tabelas Drift ou rotas:

```bash
dart run build_runner build --delete-conflicting-outputs
dart analyze
flutter test
```

## Checklist de Teste Funcional

1. Cadastrar empresa com CNPJ valido.
2. Tentar cadastrar CNPJ duplicado (deve retornar erro amigavel).
3. Buscar empresa por CNPJ existente e inexistente.
4. Editar dados da empresa e confirmar persistencia.
5. Excluir empresa e validar atualizacao da lista.

## Nota Historica

Versoes antigas deste documento citavam paths e schema versions anteriores (ex.: repositores em `lib/core/repository/` e schema `9`). O estado atual do projeto usa repositores em `lib/domain/repository/` e schema `12` no `AppDatabase`.
