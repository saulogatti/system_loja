# Contratos

Interfaces em `lib/core/interface/` consumidas pela apresentação.

A UI resolve `appInjection.get<IXxxRepository>()` e trata o retorno com `when`/`switch` em `ResultStatus` — sem `try/catch` nas chamadas de repositório.

Guia: `docs/INTERFACES_ARCHITECTURE.md`.
