# GitHub Copilot Setup Overview

Este documento fornece uma visão geral completa da configuração do GitHub Copilot para o projeto System Loja.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Arquivos de Configuração](#arquivos-de-configuração)
- [Custom Agents](#custom-agents)
- [Path-Specific Instructions](#path-specific-instructions)
- [Como Usar](#como-usar)
- [Manutenção](#manutenção)

## Visão Geral

O projeto System Loja está totalmente configurado para trabalhar com GitHub Copilot através de:

1. **Instruções Globais** (`.github/copilot-instructions.md`) - Contexto arquitetural e padrões principais
2. **Custom Agents** (`.github/agents/*.agent.md`) - Agentes especializados para tarefas específicas
3. **Path-Specific Instructions** (`.github/instructions/*.instructions.md`) - Padrões específicos por tipo de arquivo
4. **Implementation Guidelines** (`.github/agent-implementation-instructions.md`) - Guia detalhado de implementação
5. **Commit Message Standards** (`.github/copilot-commit-message-instructions.md`) - Padrões de mensagens de commit

## Arquivos de Configuração

### 1. Instruções Globais do Repositório

**Arquivo:** `.github/copilot-instructions.md`  
**Aplica-se a:** Todo o repositório  
**Conteúdo:**
- Visão geral da arquitetura (Drift ORM, BLoC, Material 3)
- **Arquitetura limpa** (obrigatória): domínio em `lib/core/`, dados em `lib/data/`, repositórios em `lib/domain/`
- **Sem obrigação de compatibilidade retroativa** enquanto o app está em desenvolvimento
- Padrões críticos (Drift DAO, ResultStatus, Code Generation, repository_error_mapper)
- Workflows de desenvolvimento
- Code style requirements
- Known gotchas

**Quando é usado:** Sempre que o Copilot trabalha no repositório.

---

### 2. Padrões de Mensagens de Commit

**Arquivo:** `.github/copilot-commit-message-instructions.md`  
**Aplica-se a:** Mensagens de commit  
**Formato:**
```
<tipo>: <descrição concisa>
```

**Tipos comuns:**
- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Atualização de documentação
- `style`: Formatação/correção de estilo
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes

---

### 3. Guia de Implementação para Agentes

**Arquivo:** `.github/agent-implementation-instructions.md`  
**Aplica-se a:** Todos os agentes (automáticos ou custom)  
**Conteúdo:**
- Contexto arquitetural detalhado
- Padrões obrigatórios (ResultStatus, Models, BLoC, Documentação, repository_error_mapper)
- Workflow completo de desenvolvimento
- Convenções de código
- Estrutura de testes
- Code review checklist
- Guia de evitar duplicação de código
- Troubleshooting comum

---

## Custom Agents

### 🛠️ Flutter Developer

**Arquivo:** `.github/agents/flutter-developer.agent.md`  
**Especialidade:** Desenvolvimento Flutter/Dart  
**Use para:**
- Implementar novas features com Drift ORM + BLoC
- Corrigir bugs em código Dart/Flutter
- Refatorar código mantendo compatibilidade
- Migrar código JSON legacy para Drift ORM

**Invocação:**
```
@flutter-developer implement customer registration form with validation
```

---

### 🧪 Test Specialist

**Arquivo:** `.github/agents/test-specialist.agent.md`  
**Especialidade:** Testes unitários e integração  
**Use para:**
- Criar testes unitários para models, repositories e BLoCs
- Criar testes de integração para fluxos completos
- Revisar cobertura de testes
- Corrigir testes quebrados após refatorações

**Invocação:**
```
@test-specialist create unit tests for CustomerRepository
```

---

### 📚 Documentation Specialist

**Arquivo:** `.github/agents/documentation-specialist.agent.md`  
**Especialidade:** Documentação técnica  
**Use para:**
- Criar/atualizar documentação em `docs/`
- Documentar código com `///` doc comments em português
- Manter README.md atualizado
- Criar guias para contribuidores

**Invocação:**
```
@documentation-specialist document the CustomerRepository API
```

---

## Path-Specific Instructions

### Padrões Dart (Effective Dart)

**Arquivo:** `.github/instructions/dartcode.instructions.md`  
**Aplica-se a:** `**/*.dart`  
**Conteúdo:**
- Glossário de termos Dart
- Resumo das regras (Estilo, Ordem, Formatação)
- Regras de documentação
- Markdown em doc comments
- Padrões de escrita
- Uso de bibliotecas, null safety, strings, coleções
- Funções e variáveis
- Membros e construtores
- Tratamento de erros
- Assincronismo
- Design patterns

**Quando é usado:** Sempre que Copilot trabalha com arquivos `.dart`.

---

## Como Usar

### Desenvolvimento Normal (Sem Agente Específico)

Quando você faz uma solicitação ao Copilot sem especificar um agente, ele usa:
1. Instruções globais (`.github/copilot-instructions.md`)
2. Path-specific instructions (`.github/instructions/dartcode.instructions.md` para arquivos `.dart`)
3. Implementation guidelines (`.github/agent-implementation-instructions.md`)

**Exemplo:**
```
Implement a new product registration screen with BLoC
```

---

### Usando Custom Agents

Para tarefas especializadas, invoque um custom agent:

**Desenvolvimento:**
```
@flutter-developer add quantity field to Product model and update all related code
```

**Testes:**
```
@test-specialist create comprehensive tests for the new quantity field functionality
```

**Documentação:**
```
@documentation-specialist update docs to explain the new quantity field feature
```

---

### Workflow Recomendado

1. **Implementação:** Use `@flutter-developer` para desenvolver a feature
2. **Testes:** Use `@test-specialist` para criar testes
3. **Documentação:** Use `@documentation-specialist` para documentar
4. **Review:** Peça ao Copilot para revisar o código completo

**Exemplo completo:**
```
Step 1: @flutter-developer implement discount field in Product with validation
Step 2: @test-specialist create tests for discount field validation
Step 3: @documentation-specialist add doc comments for discount field
Step 4: Review the changes and ensure all tests pass
```

---

## Manutenção

### Atualizando Instruções

Quando atualizar qualquer arquivo de instruções:

1. **Teste as mudanças** criando uma issue de exemplo
2. **Verifique consistência** com outros arquivos de instruções
3. **Documente** mudanças significativas no commit
4. **Atualize este documento** se necessário

### Adicionando Novo Custom Agent

1. Crie arquivo `.github/agents/[agent-name].agent.md`
2. Use a estrutura YAML + Markdown:
   ```yaml
   ---
   name: Agent Name
   description: Short description
   target: github-copilot
   tools: [read, edit, create, bash]
   infer: false
   metadata:
     domain: your-domain
   ---
   
   # Instructions...
   ```
3. Atualize `.github/agents/README.md`
4. Atualize este documento
5. Teste com issues reais

### Adicionando Path-Specific Instructions

1. Crie arquivo `.github/instructions/[name].instructions.md`
2. Adicione YAML frontmatter com `applyTo` pattern:
   ```yaml
   ---
   applyTo: '**/*.ext'
   ---
   
   # Instructions...
   ```
3. Atualize este documento

---

## Hierarquia de Aplicação

```
┌─────────────────────────────────────────────────┐
│ Global Copilot Instructions                     │
│ (.github/copilot-instructions.md)               │
│ - Aplica-se a todo o repositório                │
│ - Sempre ativo                                   │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Path-Specific Instructions                      │
│ (.github/instructions/*.instructions.md)        │
│ - Aplica-se a arquivos específicos              │
│ - Ativo quando trabalhando com esses arquivos   │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Custom Agent (se invocado)                      │
│ (.github/agents/*.agent.md)                     │
│ - Instruções especializadas adicionais          │
│ - Apenas quando explicitamente invocado         │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Implementation Guidelines                       │
│ (.github/agent-implementation-instructions.md)  │
│ - Guia detalhado para todos os agentes          │
│ - Sempre disponível                             │
└─────────────────────────────────────────────────┘
```

---

## Recursos Adicionais

- **GitHub Docs:** [Creating custom agents](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)
- **Best Practices:** [How to write a great agents.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- **Configuration Reference:** [Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)

---

## Feedback e Melhorias

Se você encontrar problemas com as instruções do Copilot ou tiver sugestões de melhoria:

1. Abra uma issue com label `copilot-instructions`
2. Descreva o problema ou sugestão
3. Inclua exemplos de prompts e resultados esperados vs. obtidos

---

**Última atualização:** Março 2026  
**Mantido por:** Time de desenvolvimento System Loja
