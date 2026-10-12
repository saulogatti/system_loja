# GitHub Copilot Setup Overview

This document provides a comprehensive overview of the GitHub Copilot setup for the System Loja project.

## 📋 Contents

- [Overview](#overview)
- [Configuration Files](#configuration-files)
- [Custom Agents](#custom-agents)
- [Path-Specific Instructions](#path-specific-instructions)
- [How to Use](#how-to-use)
- [Maintenance](#maintenance)

## Overview

The System Loja project is fully configured to work with GitHub Copilot through:

1. **Global instructions** (`.github/copilot-instructions.md`) - Architectural context and core standards
2. **Custom agents** (`.github/agents/*.agent.md`) - Specialized agents for specific tasks
3. **Path-specific instructions** (`.github/instructions/*.instructions.md`) - Standards for specific file types
4. **Implementation guidelines** (`.github/agent-implementation-instructions.md`) - Detailed implementation guide
5. **Commit message standards** (`.github/copilot-commit-message-instructions.md`) - Commit message conventions

## Configuration Files

### 1. Global Repository Instructions

**File:** `.github/copilot-instructions.md`<br>
**Applies to:** The entire repository<br>
**Contents:**
- Architecture overview (Drift ORM, BLoC, Material 3)
- **Required Clean Architecture**: domain in `lib/core/`, data in `lib/data/`, repositories in `lib/domain/`
- **Backward compatibility is not required** while the app is under development
- Critical patterns (Drift DAO, ResultStatus, code generation, repository_error_mapper)
- Development workflows
- Code style requirements
- Known gotchas

**When used:** Whenever Copilot works in the repository.

---

### 2. Commit Message Standards

**File:** `.github/copilot-commit-message-instructions.md`<br>
**Applies to:** Commit messages<br>
**Format:**
```
<type>: <concise description>
```

**Common types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation update
- `style`: Formatting/style change
- `refactor`: Code refactoring
- `test`: Add or update tests

---

### 3. Agent Implementation Guide

**File:** `.github/agent-implementation-instructions.md`<br>
**Applies to:** All agents (automatic or custom)<br>
**Contents:**
- Detailed architectural context
- Required patterns (ResultStatus, models, BLoC, documentation, repository_error_mapper)
- Complete development workflow
- Code conventions
- Test structure
- Code review checklist
- Guide to avoiding code duplication
- Common troubleshooting

---

## Custom Agents

### 🛠️ Flutter Developer

**File:** `.github/agents/flutter-developer.agent.md`<br>
**Specialty:** Flutter/Dart development<br>
**Use for:**
- Implementing new features with Drift ORM + BLoC
- Fixing bugs in Dart/Flutter code
- Refactoring code while maintaining compatibility
- Migrating legacy JSON code to Drift ORM

**Invocation:**
```
@flutter-developer implement customer registration form with validation
```

---

### 🧪 Test Specialist

**File:** `.github/agents/test-specialist.agent.md`<br>
**Specialty:** Unit and integration testing<br>
**Use for:**
- Creating unit tests for models, repositories, and BLoCs
- Creating integration tests for complete flows
- Reviewing test coverage
- Fixing tests broken by refactoring

**Invocation:**
```
@test-specialist create unit tests for CustomerRepository
```

---

### 📚 Documentation Specialist

**File:** `.github/agents/documentation-specialist.agent.md`<br>
**Specialty:** Technical documentation<br>
**Use for:**
- Creating/updating documentation in `documentation/`
- Writing `///` doc comments in English
- Keeping `README.md` up to date
- Creating contributor guides

**Invocation:**
```
@documentation-specialist document the CustomerRepository API
```

---

## Path-Specific Instructions

### Dart Standards (Effective Dart)

**File:** `.github/instructions/dartcode.instructions.md`<br>
**Applies to:** `**/*.dart`<br>
**Contents:**
- Glossary of Dart terms
- Summary of rules (style, ordering, formatting)
- Documentation rules
- Markdown in doc comments
- Writing conventions
- Library usage, null safety, strings, and collections
- Functions and variables
- Members and constructors
- Error handling
- Asynchrony
- Design patterns

**When used:** Whenever Copilot works with `.dart` files.

---

## How to Use

### Standard Development (Without a Specific Agent)

When you ask Copilot for something without specifying an agent, it uses:
1. Global instructions (`.github/copilot-instructions.md`)
2. Path-specific instructions (`.github/instructions/dartcode.instructions.md` for `.dart` files)
3. Implementation guidelines (`.github/agent-implementation-instructions.md`)

**Example:**
```
Implement a new product registration screen with BLoC
```

---

### Using Custom Agents

For specialized tasks, invoke a custom agent:

**Development:**
```
@flutter-developer add quantity field to Product model and update all related code
```

**Testing:**
```
@test-specialist create comprehensive tests for the new quantity field functionality
```

**Documentation:**
```
@documentation-specialist update docs to explain the new quantity field feature
```

---

### Recommended Workflow

1. **Implementation:** Use `@flutter-developer` to build the feature.
2. **Testing:** Use `@test-specialist` to create tests.
3. **Documentation:** Use `@documentation-specialist` to document the work.
4. **Review:** Ask Copilot to review the complete code.

**Complete example:**
```
Step 1: @flutter-developer implement discount field in Product with validation
Step 2: @test-specialist create tests for discount field validation
Step 3: @documentation-specialist add doc comments for discount field
Step 4: Review the changes and ensure all tests pass
```

---

## Maintenance

### Updating Instructions

When updating any instruction file:

1. **Test the changes** by creating a sample issue.
2. **Check consistency** with other instruction files.
3. **Document** significant changes in the commit.
4. **Update this document** if necessary.

### Adding a Custom Agent

1. Create a `.github/agents/[agent-name].agent.md` file.
2. Use the YAML + Markdown structure:
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
3. Update `.github/agents/README.md`.
4. Update this document.
5. Test with real issues.

### Adding Path-Specific Instructions

1. Create a `.github/instructions/[name].instructions.md` file.
2. Add YAML front matter with an `applyTo` pattern:
   ```yaml
   ---
   applyTo: '**/*.ext'
   ---
   
   # Instructions...
   ```
3. Update this document.

---

## Application Hierarchy

```
┌─────────────────────────────────────────────────┐
│ Global Copilot Instructions                     │
│ (.github/copilot-instructions.md)               │
│ - Applies to the entire repository              │
│ - Always active                                  │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Path-Specific Instructions                      │
│ (.github/instructions/*.instructions.md)        │
│ - Applies to specific files                     │
│ - Active when working with those files          │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Custom Agent (if invoked)                       │
│ (.github/agents/*.agent.md)                     │
│ - Additional specialized instructions           │
│ - Only when explicitly invoked                  │
└─────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────┐
│ Implementation Guidelines                       │
│ (.github/agent-implementation-instructions.md)  │
│ - Detailed guide for all agents                 │
│ - Always available                              │
└─────────────────────────────────────────────────┘
```

---

## Additional Resources

- **GitHub Docs:** [Creating custom agents](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)
- **Best Practices:** [How to write a great agents.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- **Configuration Reference:** [Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)

---

## Feedback and Improvements

If you find issues with Copilot instructions or have suggestions for improvement:

1. Open an issue with the `copilot-instructions` label.
2. Describe the issue or suggestion.
3. Include examples of prompts and expected versus actual results.

---

**Last updated:** March 2026<br>
**Maintained by:** System Loja development team
