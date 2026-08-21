# Guia de Contribuição - System Loja

## Bem-vindo!

Obrigado por considerar contribuir para o System Loja! Este documento fornece diretrizes para ajudar você a trabalhar efetivamente no projeto, seja sozinho ou com o GitHub Copilot Coding Agent.

## 📋 Índice

- [Como Usar o GitHub Copilot Coding Agent](#como-usar-o-github-copilot-coding-agent)
- [Padrões de Código](#padrões-de-código)
- [Fluxo de Trabalho](#fluxo-de-trabalho)
- [Como Criar Issues](#como-criar-issues)
- [Como Criar Pull Requests](#como-criar-pull-requests)
- [Executando Testes](#executando-testes)
- [Estrutura do Projeto](#estrutura-do-projeto)

---

## 🤖 Como Usar o GitHub Copilot Coding Agent

O GitHub Copilot Coding Agent pode ajudar a automatizar tarefas de desenvolvimento neste repositório. Para obter os melhores resultados:

### Preparação

1. **Leia a documentação do repositório** antes de criar issues:
   - `.github/copilot-instructions.md` - Instruções técnicas para o Copilot
   - `.github/instructions/dartcode.instructions.md` - Padrões de código Dart
   - Este arquivo (`CONTRIBUTING.md`) - Guia de contribuição geral

2. **Verifique as convenções do projeto**:
   - **Clean Architecture**: UI → interfaces em `lib/core/interface/` → repositórios em `lib/domain/repository/` → `lib/data/` (Drift, DTOs, mapeadores)
   - Persistência principal: **SQLite via Drift** (sem backend externo); DTOs JSON em `lib/data/entry/` quando necessário
   - Documentação em português usando comentários `///`
   - Material Design 3 para interface
   - Codegen: `dart run build_runner build` após Freezed / JsonSerializable / Drift / AutoRoute

### Tarefas Ideais para o Copilot Agent

O Copilot Agent é mais eficaz em tarefas bem definidas e de escopo limitado:

✅ **Boas tarefas para o Agent:**
- Adicionar novos campos a modelos existentes
- Criar validações de formulário
- Corrigir bugs específicos e bem documentados
- Refatorar código seguindo padrões estabelecidos
- Melhorar cobertura de testes
- Atualizar documentação
- Implementar features pequenas e incrementais

❌ **Tarefas a evitar para o Agent:**
- Mudanças arquiteturais amplas
- Refatorações em múltiplos módulos
- Alterações críticas de segurança sem supervisão
- Tarefas ambíguas ou mal definidas

### Como Criar Issues para o Copilot Agent

Para que o Agent trabalhe efetivamente, suas issues devem ser:

1. **Claras e específicas**:
   ```markdown
   ❌ Ruim: "Melhorar tela de clientes"
   ✅ Bom: "Adicionar campo 'Data de Nascimento' ao cadastro de clientes com validação de idade mínima de 18 anos"
   ```

2. **Incluir critérios de aceitação**:
   ```markdown
   **Critérios de Aceitação:**
   - [ ] Campo dataNascimento adicionado ao modelo Cliente
   - [ ] Validação de idade >= 18 anos implementada
   - [ ] Campo visível no formulário de cadastro
   - [ ] Testes unitários para validação criados
   - [ ] Documentação atualizada em português
   ```

3. **Especificar arquivos afetados** (quando possível):
   ```markdown
   **Arquivos Esperados:**
   - `lib/core/models/cliente.dart`
   - `lib/screens/cliente_screen.dart`
   - `test/models/cliente_test.dart`
   ```

4. **Fornecer contexto necessário**:
   ```markdown
   **Contexto:**
   Este campo é necessário para validar a maioridade do cliente antes de
   permitir compras. O formato deve ser DD/MM/AAAA no formulário, mas
   armazenado como ISO 8601 no JSON.
   ```

### Revisando Pull Requests do Agent

Trate os PRs do Copilot Agent como você trataria código de qualquer desenvolvedor:

1. **Revise cuidadosamente o código**
2. **Execute os testes**: `flutter test`
3. **Teste manualmente** a funcionalidade
4. **Verifique se segue os padrões** do projeto
5. **Solicite mudanças** se necessário mencionando `@copilot` nos comentários
6. **Aprove e merge** somente após validação completa

---

## 💻 Padrões de Código

### Convenções de Nomenclatura

- **Arquivos e pastas**: `lowercase_with_underscores`
- **Classes e Types**: `UpperCamelCase`
- **Variáveis e funções**: `lowerCamelCase`
- **Constantes**: `lowerCamelCase` (preferido) ou `UPPER_SNAKE_CASE`

### Documentação

**SEMPRE** documente código público em **português**:

```dart
/// Gerencia operações CRUD de clientes via Drift.
///
/// Todos os métodos retornam [ResultStatus] — sem propagar exceções para a UI.
class CustomerRepository implements ICustomerRepository {
  /// Busca um cliente pelo ID.
  ///
  /// Retorna [ResultStatus] com o [Customer] ou mensagem de erro amigável.
  Future<ResultStatus<Customer, String>> buscar({required int id}) async { ... }
}
```

### Padrões Arquiteturais

#### Camadas (atual)

- **Interface + ResultStatus**: operações expostas à UI retornam `ResultStatus<R, E>` (`lib/core/utils/result_status.dart`, usa `package:meta`); não propagar exceções através de repositório/interface.
- **Repositórios** (`lib/domain/repository/`): orquestram DAOs e regras; usam `try/catch` internamente e retornam `ResultStatus.error(mensagemErroRepositorio(...))` com mensagens amigáveis (`lib/core/utils/repository_error_mapper.dart`). Dependem de interfaces e de tipos de `lib/core/models/`.
- **Apresentação** (`lib/screens/`): **não** envolve chamadas ao repositório em `try/catch`; usa `when`/`switch` no `ResultStatus` e emite estado de erro com a mensagem já tratada.
- **Dados** (`lib/data/`): tabelas/DAOs Drift, DTOs em `entry/` etc., mapeamento registro → domínio; **sem** imports de `domain/` ou `application/`. `CacheManager` é registrado via `GetIt` (DI) — não usar `CacheManager.instance`.
- **DI**: `setupAppInjection()` em `lib/application/app_injection.dart`; resolver com `appInjection.get<T>()`.

#### Persistência

- **Principal**: Drift (`AppDatabase` schema 12 / `SystemDatabase` schema 1); IDs auto-incrementais onde a tabela usar `autoIncrement()`. `SystemDatabase` aceita `QueryExecutor` opcional no construtor para testes com banco em memória.
- **DTOs JSON**: em `lib/data/entry/` quando necessário (serialização/importação). Não há pasta `lib/core/managers/`.

### Flutter UI

- **Material Design 3** com `ColorScheme.fromSeed()`
- **Validação de formulários** com `GlobalKey<FormState>()`
- **Modal bottom sheets** para detalhes: `showModalBottomSheet()`
- **SnackBar** para feedback ao usuário
- **Dispose** de controllers sempre

---

## 🔄 Fluxo de Trabalho

### Para Desenvolvedores Humanos

1. **Fork** o repositório
2. **Crie uma branch** para sua feature: `git checkout -b feature/minha-feature`
3. **Faça commits** frequentes e descritivos
4. **Gere código** se alterou Freezed/Json/Drift/AutoRoute: `dart run build_runner build`
5. **Execute os testes**: `flutter test`
6. **Execute o linter**: `dart analyze`
7. **Formate o código**: `dart format .`
8. **Push** para seu fork: `git push origin feature/minha-feature`
9. **Abra um Pull Request** para o branch `main`

### Para o Copilot Coding Agent

1. **Issue atribuída** ao @copilot (automaticamente ou manualmente)
2. **Agent cria branch** automaticamente
3. **Agent implementa** as mudanças
4. **Agent abre PR** para revisão
5. **Humanos revisam** e solicitam mudanças se necessário
6. **Agent itera** baseado no feedback
7. **Humanos aprovam** e fazem merge após validação

---

## 📝 Como Criar Issues

Use os templates disponíveis em `.github/ISSUE_TEMPLATE/`:

- **Bug Report** (`bug_report.md`): Para reportar problemas
- **Feature Request** (`feature_request.md`): Para sugerir melhorias

### Elementos Importantes

Toda issue deve conter:

1. **Título claro e conciso**
2. **Descrição detalhada** do problema ou feature
3. **Critérios de aceitação** (especialmente para o Copilot Agent)
4. **Contexto adicional** (screenshots, logs, exemplos)
5. **Labels apropriados** (bug, enhancement, documentation, etc.)

### Exemplo de Issue Boa

```markdown
# Adicionar Validação de Email no Cadastro de Clientes

## Descrição
Atualmente o campo de email aceita qualquer texto. Precisamos validar
se o email está em formato válido antes de salvar.

## Critérios de Aceitação
- [ ] Validação de formato de email no formulário
- [ ] Mensagem de erro clara quando email inválido
- [ ] Não permitir salvar cliente com email inválido
- [ ] Testes unitários para validação
- [ ] Documentação atualizada

## Arquivos Afetados
- `lib/screens/cliente_screen.dart`
- `test/screens/cliente_screen_test.dart`

## Contexto Adicional
Usar regex padrão de validação de email. Mostrar erro abaixo do campo.
```

---

## 🔀 Como Criar Pull Requests

### Checklist do PR

Antes de criar um PR, certifique-se de:

- [ ] Código segue os padrões do projeto
- [ ] Todos os testes passam: `flutter test`
- [ ] Código está formatado: `dart format .`
- [ ] Sem warnings do linter: `dart analyze`
- [ ] Documentação atualizada (se aplicável)
- [ ] Comentários em português
- [ ] Commits descritivos e organizados

### Título e Descrição

**Título**: Use prefixos convencionais
- `feat:` para novas funcionalidades
- `fix:` para correções de bugs
- `docs:` para mudanças em documentação
- `refactor:` para refatorações
- `test:` para adição/modificação de testes
- `chore:` para tarefas de manutenção

**Descrição**: Explique o que foi feito e por quê
```markdown
## O que foi feito
- Adicionado campo dataNascimento ao modelo Cliente
- Implementada validação de idade mínima

## Por que foi feito
Para garantir que apenas maiores de 18 anos possam ser cadastrados

## Como testar
1. Executar `flutter test`
2. Abrir tela de clientes
3. Tentar cadastrar cliente com menos de 18 anos
4. Verificar que mostra erro de validação
```

---

## 🧪 Executando Testes

### Testes Unitários

```bash
# Executar todos os testes
flutter test

# Executar teste específico
flutter test test/models/cliente_test.dart

# Executar com coverage
flutter test --coverage
```

### Testes Manuais

```bash
# Desktop
flutter run -d windows
flutter run -d macos
flutter run -d linux

# Mobile (com emulador/dispositivo)
flutter run

# Web
flutter run -d chrome
```

### Validação de Código

```bash
# Analisar código
dart analyze

# Formatar código
dart format .

# Verificar formatação sem aplicar
dart format --set-exit-if-changed .
```

---

## 📁 Estrutura do Projeto

```
system_loja/
├── .github/
│   ├── copilot-instructions.md          # Instruções para Copilot Agent
│   ├── instructions/
│   │   └── dartcode.instructions.md     # Padrões de código Dart
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── lib/
│   ├── main.dart
│   ├── application/
│   │   └── app_injection.dart           # DI (GetIt)
│   ├── core/
│   │   ├── interface/                   # Contratos (ex.: ICustomerRepository)
│   │   ├── models/                      # Entidades de domínio
│   │   ├── services/                    # Serviços transversais (quando aplicável)
│   │   └── utils/                       # ResultStatus, helpers
│   ├── domain/
│   │   └── repository/                  # Implementações de repositório
│   ├── data/
│   │   ├── database/                    # Drift: DAOs, tabelas, mapper/, extension/
│   │   ├── entry/                       # DTOs JSON
│   │   ├── cache/, converter/, models/
│   └── screens/                         # UI, BLoC/Cubit, rotas
├── test/
│   └── support/                         # Helpers (ex.: AppDatabase em teste)
├── docs/
│   └── historico/                       # Material antigo (não canônico)
├── CONTRIBUTING.md
└── README.md
```

O fluxo principal da aplicação usa SQLite embutido via Drift.

---

## 🔗 Links Úteis

- **Documentação Flutter**: https://flutter.dev/docs
- **Effective Dart**: https://dart.dev/guides/language/effective-dart
- **Material Design 3**: https://m3.material.io/
- **GitHub Copilot Docs**: https://docs.github.com/en/copilot
- **Copilot Coding Agent Best Practices**: https://docs.github.com/en/copilot/tutorials/coding-agent/get-the-best-results

---

## 🆘 Precisa de Ajuda?

- Abra uma issue com a label `question`
- Revise a documentação em `.github/copilot-instructions.md`
- Consulte o `README.md` para informações básicas

---

## 📄 Licença

Este projeto é de código aberto. Ao contribuir, você concorda que suas contribuições serão licenciadas sob os mesmos termos do projeto.

---

**Obrigado por contribuir para o System Loja! 🚀**
