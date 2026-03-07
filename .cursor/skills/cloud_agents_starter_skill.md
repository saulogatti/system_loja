# Skill inicial mínima para agentes Cloud

## Quando usar

Use esta skill no início de qualquer tarefa para subir o ambiente rápido,
executar o app e validar mudanças por área do código sem perder tempo com
tentativas aleatórias.

## Pré-voo (2-3 minutos)

1. Verifique versões e dispositivos:
   - `flutter --version`
   - `flutter devices`
2. Instale dependências:
   - `flutter pub get`
3. Gere código se o branch já veio com mudanças em `freezed`, `json_serializable`,
   Drift ou AutoRoute:
   - `dart run build_runner build --delete-conflicting-outputs`
4. Faça um sanity check rápido:
   - `dart analyze`

## Login, autenticação e permissões

- **Não há login obrigatório de backend** neste projeto para iniciar a aplicação.
- O app roda local com SQLite/Drift embutido, sem API externa.
- Para cenários de permissão, use a área de usuários (`Configurações > Usuários`)
  e os níveis `administrador` e `usuarioComum`.
- Se o fluxo exigir senha ao abrir o app, isso é controlado por configuração local
  (`AppSettings.exigirSenha`), não por provedor externo de identidade.

## Feature flags / toggles (o que existe aqui)

- Não existe um serviço central de feature flags remotas.
- O equivalente prático são toggles persistidos em `AppSettings` (notificações,
  tema, segurança, backup etc.).
- Caminhos práticos para alterar comportamento:
  - Via UI: `Configurações` (fluxo preferido para validação manual).
  - Via código/teste: `AppSettings.createDefaultSettings().copyWith(...)` e
    `updateAppSettings(...)` no repositório de configuração.
- Para voltar ao estado conhecido, use “restaurar padrão” na própria tela de
  configurações ou limpe dados de cache local durante testes controlados.

## Subir a aplicação (Cloud)

### Opção A (recomendada para agente Cloud): web-server

1. Suba o app:
   - `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
2. Confirme que `web/sqlite3.wasm` e `web/drift_worker.js` existem (obrigatório
   para Drift no Web).

### Opção B: Linux desktop

- `flutter run -d linux`

## Workflows de teste por área do código

### 1) `lib/core/models` e serialização

Use quando alterar modelos JSON, validações de campos, extensões utilitárias.

Fluxo:
1. Rodar codegen (se houver `@JsonSerializable`):
   - `dart run build_runner build --delete-conflicting-outputs`
2. Executar testes focados:
   - `flutter test test/json_serialization_test.dart`
   - `flutter test test/validators_test.dart`

Critério de pronto:
- Roundtrip JSON funcionando e validações críticas sem regressão.

### 2) `lib/data/database` e DAOs Drift

Use quando alterar tabelas, DAOs, mapeamentos, queries e comportamento de
persistência.

Fluxo:
1. Rodar codegen Drift:
   - `dart run build_runner build --delete-conflicting-outputs`
2. Executar testes de banco focados:
   - `flutter test test/category_dao_test.dart`
   - `flutter test test/invoice_dao_test.dart`
   - `flutter test test/database_helper_test.dart`

Critério de pronto:
- Testes de DAO passam e operações CRUD/consulta principais continuam consistentes.

### 3) `lib/core/repository` e interfaces

Use quando alterar regras de negócio, retornos `ResultStatus`, integração entre
camadas e contratos.

Fluxo:
1. Executar suíte relacionada ao domínio alterado (exemplos):
   - `flutter test test/sql_data_storage_test.dart`
   - `flutter test test/product_exception_test.dart`
2. Validar que erros retornam por `ResultStatus` (não exceções entre camadas).

Critério de pronto:
- Sem regressão de regra de negócio e sem quebra de contrato entre repository/DAO.

### 4) `lib/screens/**` (UI, BLoC/Cubit, widgets, rotas)

Use quando alterar telas, eventos/estados freezed, navegação ou componentes visuais.

Fluxo:
1. Rodar codegen quando mexer em Freezed/AutoRoute:
   - `dart run build_runner build --delete-conflicting-outputs`
2. Rodar testes focados de UI/widget:
   - `flutter test test/loading_overlay_test.dart`
   - `flutter test test/product_category_widget_test.dart`
   - `flutter test test/cliente_screen_search_test.dart`
3. Validar manualmente com app rodando:
   - navegar pela área alterada
   - executar fluxo feliz + 1 cenário de erro
   - confirmar mensagens/feedback visual

Critério de pronto:
- Tela funciona ponta a ponta e estado da UI reflete corretamente o estado do BLoC/Cubit.

### 5) Inicialização e DI (`lib/main.dart`, `lib/app_injection.dart`, rotas)

Use quando alterar bootstrap, registro de dependências ou router.

Fluxo:
1. Subir app (`web-server` ou `linux`) e validar inicialização sem erro.
2. Executar smoke test de navegação:
   - abrir Home
   - navegar para Cadastro, Vendas e Configurações
   - retornar para Home sem crash

Critério de pronto:
- App inicia sem falhas e resolve dependências/rotas esperadas.

## Sequência mínima recomendada por task

1. `flutter pub get`
2. `dart run build_runner build --delete-conflicting-outputs` (quando aplicável)
3. Testes focados por área alterada
4. `dart analyze`
5. Validação manual curta no app (quando houver mudança visual ou fluxo de usuário)

## Limitações conhecidas no repositório

- Existem falhas pré-existentes em alguns testes; priorize as suítes diretamente
  relacionadas ao escopo alterado.
- A suíte `test/validators_test.dart` é conhecida como estável para sanity check.

## Como atualizar esta skill quando surgirem novos truques de teste/runbook

Sempre que descobrir um comando, workaround ou fluxo de validação que economize
tempo real:

1. Adicione o aprendizado na seção da **área afetada** (models, database,
   repository, screens ou bootstrap).
2. Inclua **comando exato**, **quando usar** e **sinal esperado de sucesso**.
3. Se substituir um passo antigo, remova o passo obsoleto na mesma alteração.
4. Mantenha esta skill curta e operacional (evite teoria longa).

Regra prática: se um novo agente teria dificuldade de executar/testar sem aquela
informação, essa informação deve entrar nesta skill.
