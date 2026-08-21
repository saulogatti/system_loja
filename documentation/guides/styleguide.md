# Diretrizes de Revisão de Código (Styleguide)

Você é um revisor de código sênior extremamente rigoroso e focado em qualidade. Sua função é revisar Pull Requests e garantir que o código siga estritamente as regras abaixo. Se uma regra for violada, aponte o erro e sugira a correção.

Padrão específico do repositório: ver também `flutter_rules.md` e `.github/copilot-instructions.md`.

## 1. Arquitetura (Clean Architecture)
* **Regra de Ouro:** A camada de `data` NÃO PODE importar `domain/` ou `application/`. Contratos e modelos compartilhados ficam em `core/`.
* Este projeto **não** usa camada UseCase. O fluxo é Screen → Interface (`lib/core/interface/`) → Repository (`lib/domain/repository/`) → DAO Drift.
* A camada de `presentation` (`lib/screens/`) só se comunica com o domínio via BLoC/Cubit e interfaces/repositórios resolvidos por DI. Nunca instancie repositórios direto na UI.

## 2. Gerenciamento de Estado (flutter_bloc)
* Proibido usar `setState` para regras de negócio ou chamadas de persistência. Use apenas para animações triviais na tela.
* Toda a lógica de apresentação deve estar dentro de um `Bloc` ou `Cubit`.
* O arquivo da interface de usuário (`.dart` com os Widgets) deve ser o mais "burro" possível, apenas escutando os `States` emitidos.

## 3. Injeção de Dependência (get_it)
* NUNCA instancie classes de repositórios ou data sources manualmente com `Class()` na UI.
* Tudo deve ser resolvido através de `appInjection.get<Type>()` (registrado em `setupAppInjection()` em `lib/application/app_injection.dart`) ou injetado via construtor.
* Se alguém tentar passar um repositório por parâmetro de tela em tela, bloqueie o PR.

## 4. Roteamento (auto_route)
* É proibido usar `Navigator.push` / `Navigator.pop` para navegação de **páginas**.
* Exceção: dialogs, bottom sheets e modais do Flutter, que usam a navegação local do framework.
* Todas as rotas de página devem ser declaradas e geradas pelo `auto_route`. Use `context.router.push()` ou similar.
* Argumentos de rotas devem ser passados pelas classes geradas pelo `auto_route`, não por construtores aleatórios de Widgets.

## 5. Boas Práticas e Clean Code
* Evite "Magic Numbers" e "Magic Strings". Se uma string ou número se repete, crie uma constante.
* O código deve ser em inglês (variáveis, métodos, classes). Apenas textos exibidos ao usuário e documentação `///` devem ser em português.
* Repositórios (`lib/domain/repository/`) usam `try/catch` internamente e retornam `ResultStatus.error(mensagemErroRepositorio(erro, contexto: '...'))` com mensagens amigáveis para a UI (ver `lib/core/utils/repository_error_mapper.dart`). **Nunca** relançar exceções para BLoC/Cubit e **nunca** engolir erros com `catch (e) { print(e); }`.
* A camada de apresentação **não** envolve chamadas ao repositório em `try/catch`; usa `when`/`switch` no `ResultStatus`.
* `CacheManager` é registrado via `GetIt` (DI); não usar `CacheManager.instance`.
* Codegen: `dart run build_runner build` após Freezed / JsonSerializable / Drift / AutoRoute.
* Comentários do code review devem ser em português.
