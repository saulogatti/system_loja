---
name: flutter-bloc-widget-builder
description: "Cria e refatora telas Flutter com BLoC/Cubit no System Loja seguindo Clean Architecture, ResultStatus e widgets pequenos. Use quando precisar implementar screen, form, list, dialog, estado de UI, separacao presentation/domain/data, ou reduzir arquivos grandes sem perder legibilidade."
argument-hint: "Descreva a tela/fluxo e o comportamento esperado"
---

# Flutter Bloc Widget Builder

## Objetivo

Implementar e refatorar UI Flutter com BLoC/Cubit no contexto do System Loja, mantendo separacao de camadas, estados previsiveis e codigo facil de manter.

## Quando usar

- Criar uma nova tela com estado e eventos.
- Refatorar uma tela grande para widgets menores.
- Ajustar fluxo de loading, sucesso, vazio e erro.
- Migrar UI para seguir fronteiras de Clean Architecture.

## Processo

1. Entender o fluxo da funcionalidade e mapear estados de UI necessarios.
2. Verificar estrutura atual da feature e preservar padrao do projeto quando ja estiver adequada.
3. Definir fronteiras de camada:
- presentation: screen, bloc/cubit, widgets e interacoes de UI.
- domain/core: contratos, entidades e regras de negocio.
- data: DTOs, Drift, mapeadores e persistencia.
4. Implementar estado de apresentacao explicito (loading, success, empty, error).
5. Extrair widgets quando build ficar longo, denso ou com responsabilidades misturadas.
6. Aplicar regras do projeto para erros e repositorios:
- repositorios retornam ResultStatus.
- UI/BLoC trata retorno via when/switch, sem try/catch para chamada de repositorio.
7. Garantir injecao por GetIt e evitar acoplamento de presentation com implementacoes concretas.
8. Finalizar com validacao de legibilidade e manutencao.

## Regras especificas do System Loja

- Seguir Clean Architecture conforme instrucoes do workspace.
- Nao colocar regra de negocio em widget.
- Nao chamar DAO/Drift diretamente na camada de apresentacao.
- Evitar abstrações genericas antes de uma segunda necessidade real.
- Manter comentarios curtos e em portugues apenas quando a intencao nao for obvia.

## Checklist de qualidade

- A tela renderiza com clareza: loading, success, empty e error.
- BLoC/Cubit tem eventos/metodos com intencao explicita.
- Widgets possuem responsabilidade unica e parametros objetivos.
- Fluxo de dependencia vai de presentation para contratos, nao para implementacoes.
- O resultado final ficou mais simples que o estado inicial.

## Referencias

- Estrutura sugerida de feature: [template de feature](references/flutter-feature-template.md)
- Regras globais de projeto: .github/copilot-instructions.md
