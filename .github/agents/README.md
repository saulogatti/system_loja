# Custom Agents - System Loja

Este diretório contém custom agents especializados para GitHub Copilot, configurados para trabalhar efetivamente com o projeto System Loja.

## Agentes Disponíveis

### 🛠️ Flutter Developer (`flutter-developer.agent.md`)
Desenvolvedor especializado em Flutter/Dart focado na implementação de features e correções.

**Use quando:**
- Implementar novas funcionalidades
- Corrigir bugs em código Dart/Flutter
- Refatorar código existente
- Migrar código JSON legacy para Drift ORM

**Ferramentas:** read, edit, create, bash, grep, glob

---

### 🧪 Test Specialist (`test-specialist.agent.md`)
Especialista em testes para Flutter/Dart, focado em garantir qualidade do código.

**Use quando:**
- Criar testes unitários
- Criar testes de integração
- Revisar cobertura de testes
- Corrigir testes quebrados

**Ferramentas:** read, edit, create, bash, grep, glob

---

### 📚 Documentation Specialist (`documentation-specialist.agent.md`)
Especialista em documentação técnica para manter docs/, README e doc comments atualizados.

**Use quando:**
- Criar ou atualizar documentação em `docs/`
- Documentar código com `///` doc comments
- Atualizar README.md
- Criar guias para contribuidores

**Ferramentas:** read, edit, create, grep, glob

---

## Como Usar os Agentes

### No GitHub Copilot Chat

1. **Invocar agente específico:**
   ```
   @flutter-developer implement customer registration form
   ```

2. **Deixar Copilot escolher:**
   ```
   Implement customer registration form with validation
   ```
   (Copilot escolherá o agente apropriado se `infer: false`)

### Especificidade dos Agentes

Cada agente tem `infer: false`, o que significa que você deve invocá-los explicitamente quando quiser usá-los, ou o Copilot usará as instruções gerais.

## Estrutura de um Agent File

```yaml
---
name: Agent Name
description: Short description of the agent's expertise
target: github-copilot
tools:
  - read
  - edit
  - create
  - bash
infer: false
metadata:
  domain: development|testing|documentation
---

# Agent Instructions

Detailed instructions for the agent...
```

## Mantendo os Agentes

### Ao Adicionar Novo Agente

1. Crie arquivo `.agent.md` neste diretório
2. Siga a estrutura YAML + Markdown
3. Defina `infer: false` para controle manual
4. Liste ferramentas necessárias em `tools:`
5. Atualize este README

### Ao Modificar Agente Existente

1. Mantenha consistência com outros agentes
2. Teste as mudanças criando issues de exemplo
3. Documente mudanças significativas

## Best Practices

1. **Seja específico**: Agentes devem ter responsabilidades claras e não sobrepostas
2. **Seja conciso**: Instruções claras mas não excessivamente longas
3. **Use exemplos**: Código de exemplo ajuda o agente a entender padrões
4. **Defina limites**: Deixe claro o que o agente NÃO deve fazer
5. **Mantenha atualizado**: Agentes devem refletir o estado atual do projeto

## Recursos

- [GitHub Docs: Creating custom agents](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)
- [Best practices for agents.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- [Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)

## Hierarquia de Instruções

```
.github/
├── copilot-instructions.md           # Instruções globais do repositório
├── copilot-commit-message-instructions.md  # Padrões de mensagem de commit
├── agent-implementation-instructions.md    # Guia detalhado de implementação
├── instructions/
│   └── dartcode.instructions.md      # Padrões específicos de Dart (aplica-se a **/*.dart)
└── agents/
    ├── flutter-developer.agent.md    # Agente de desenvolvimento
    ├── test-specialist.agent.md      # Agente de testes
    └── documentation-specialist.agent.md  # Agente de documentação
```

Quando um agente é invocado, ele tem acesso às instruções globais (`copilot-instructions.md`) e às suas instruções específicas neste diretório.
