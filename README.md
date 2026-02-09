# System Loja

Sistema de gerenciamento de loja desenvolvido em Flutter com arquitetura moderna e persistência de dados dual (JSON + SQLite).

> **🤖 Usando GitHub Copilot?** Leia o [Guia de Contribuição](CONTRIBUTING.md) e [.github/copilot-instructions.md](.github/copilot-instructions.md) para obter os melhores resultados!

## 📚 Índice

- [Descrição](#descrição)
- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Como Executar](#como-executar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuindo](#contribuindo)
- [Documentação](#documentação)

## Descrição

Aplicação Flutter **multiplataforma** (Windows, macOS, iOS, Android) para gerenciamento de loja com arquitetura moderna:

- **State Management**: BLoC com `flutter_bloc` e `freezed`
- **Persistência**: Drift ORM (SQLite type-safe) + JSON (legacy)
- **Code Generation**: `drift`, `json_serializable`, `freezed`, `build_runner`
- **Padrões**: Repository Pattern, Manager Pattern, OperationResult
- **Navegação**: Auto Route para navegação declarativa
- **Material Design 3**: Interface moderna e responsiva

### Funcionalidades

1. **Cadastro de Cliente**
   - Adicionar novos clientes
   - Listar todos os clientes
   - Buscar cliente por CPF
   - Dados: Nome, CPF, Email, Telefone, Endereço

2. **Cadastro de Produto**
   - Adicionar novos produtos
   - Listar todos os produtos
   - Buscar produto por código
   - Dados: Nome, Código, Preço, Estoque, Descrição, Categoria

3. **Cadastro de Nota Fiscal de Compra**
   - Criar notas fiscais vinculadas a clientes
   - Adicionar múltiplos itens (produtos) por nota
   - Listar todas as notas fiscais
   - Buscar nota fiscal por número
   - Dados: Número, Cliente, Itens, Valor Total, Forma de Pagamento

4. **Cadastro de Empresa**
   - Dados da empresa (razão social, CNPJ, endereço, contato)
   - Visualização e edição com formulário dedicado

5. **Categorias de Produto**
   - Gestão de categorias para organização dos produtos
   - Tela de gerenciamento de categorias (CRUD)

6. **Configurações**
   - Usuários e permissões
   - Configurações do sistema (banco de dados, backup, notificações, tema)
   - Logs do sistema e análise de atividades

## Requisitos

- Flutter SDK 3.38 ou superior
- Dart SDK 3.10.8 ou superior (incluído no Flutter, conforme `pubspec.yaml`)
- SQLite (incluído no Flutter desktop)

## Como Instalar o Flutter

### Linux/macOS
```bash
# Baixe o Flutter SDK (versão 3.38 ou superior)
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.38.0-stable.tar.xz
tar xf flutter_linux_3.38.0-stable.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"

# Verifique a instalação
flutter doctor
```

### Windows
Baixe o instalador em: https://flutter.dev/docs/get-started/install/windows

## Como Executar

1. Clone o repositório:
```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Gere o código necessário (models, BLoC):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Execute o aplicativo:
```bash
# Para executar no Chrome (Web)
flutter run -d chrome

# Para executar no Windows
flutter run -d windows

# Para executar no Linux
flutter run -d linux

# Para executar no Android/iOS (com emulador/dispositivo conectado)
flutter run
```

## Estrutura de Dados

O projeto utiliza **persistência dual**:

### Sistema Principal (Drift ORM)
- **ORM Type-Safe**: Drift para SQLite com validações em tempo de compilação
- **Banco**: `system_loja.db` (criado automaticamente)
- **Tabelas**: clientes, produtos, categorias, empresas, endereços, notas fiscais, itens de nota, usuários, logs do sistema
- **DAOs**: Data Access Objects em `lib/data/database/dao/` (customer_dao, product_dao, category_dao, company_dao, address_dao, invoice_dao, invoice_item_dao, users_dao, log_dao, system_dao, sales_dao)
- **Migrations**: Versionamento de schema com drift_dev
- **Suporte**: Transações, relacionamentos, queries type-safe

### Sistema Legacy (JSON - Descontinuado)
- `data/clientes.json` - Dados dos clientes
- `data/produtos.json` - Dados dos produtos
- `data/notas_fiscais.json` - Dados das notas fiscais
- Managers em `lib/core/managers/` (em processo de migração)

## Estrutura do Projeto

```
system_loja/
├── lib/
│   ├── main.dart                 # Ponto de entrada com Material 3
│   ├── app_injection.dart        # Dependency Injection (GetIt)
│   ├── colors.dart               # Cores Material Design
│   ├── core/
│   │   ├── models/               # Modelos com @JsonSerializable
│   │   │   ├── customer.dart     # Customer (Cliente)
│   │   │   ├── product.dart      # Product (Produto)
│   │   │   ├── category.dart     # Category (Categoria)
│   │   │   ├── company.dart      # Company (Empresa)
│   │   │   ├── address.dart      # Endereço
│   │   │   ├── invoice.dart      # Invoice (Nota Fiscal)
│   │   │   ├── invoice_item.dart
│   │   │   ├── user.dart         # User (Usuário)
│   │   │   ├── activity_log.dart  # Log de atividades
│   │   │   └── system_config/    # Configurações do sistema
│   │   ├── interface/            # Contratos (repositórios, serviços)
│   │   ├── repository/           # Repositories (Repository Pattern)
│   │   │   ├── customer_repository.dart
│   │   │   ├── product_repository.dart
│   │   │   ├── category_repository.dart
│   │   │   ├── company_repository.dart
│   │   │   ├── sales_repository.dart
│   │   │   └── system/           # log, system, user_repository
│   │   ├── managers/             # Configuração, cache, erros
│   │   ├── services/             # Code generator, etc.
│   │   ├── settings/             # App settings, tema
│   │   ├── exceptions/           # Exceções de negócio
│   │   └── utils/
│   │       ├── command_result.dart     # OperationResult pattern
│   │       ├── string_extensions.dart  # File name safety
│   │       ├── validators.dart         # Validações
│   │       └── input_formatters.dart   # Formatadores de entrada
│   ├── data/
│   │   ├── database/             # Drift ORM (principal)
│   │   │   ├── app_database.dart
│   │   │   ├── system_database.dart
│   │   │   ├── table/            # Tabelas Drift (customers, products, categories, company, invoices, users, logs...)
│   │   │   ├── dao/              # Data Access Objects
│   │   │   └── extension/       # Companions para persistência
│   │   ├── cache/                # Cache (system_cache_manager)
│   │   └── files_utility/       # Utilitários de arquivo
│   └── screens/
│       ├── home/                 # Tela principal
│       ├── customer/             # Módulo de clientes (BLoC)
│       ├── products/             # Módulo de produtos (Cubit)
│       ├── sales/                # Módulo de vendas (Cubit)
│       ├── company/              # Cadastro de empresa (BLoC)
│       ├── categories/           # Gestão de categorias (Cubit)
│       ├── configuracoes/        # Configurações, usuários, logs, tema
│       ├── settings/             # Settings service
│       ├── route/                # Auto Route (route_app.dart)
│       ├── utils/                # Constantes
│       └── widgets/              # Widgets compartilhados (address_form, loading_overlay, etc.)
├── test/                        # Testes unitários e integração
├── docs/                        # Documentação detalhada
├── pubspec.yaml
└── README.md
```

## Funcionalidades da Interface

### Tela Inicial
- Menu principal com acesso às 3 funcionalidades
- Cards interativos com ícones e cores diferenciadas

### Tela de Clientes
- Formulário para cadastro de novos clientes
- Lista de clientes cadastrados
- Detalhes do cliente em modal

### Tela de Produtos
- Formulário para cadastro de novos produtos
- Lista de produtos cadastrados
- Detalhes do produto em modal
- Controle de estoque

### Tela de Notas Fiscais
- Listagem de todas as notas fiscais
- Botão flutuante para criar nova nota
- Formulário com seleção de cliente
- Adição de múltiplos produtos
- Cálculo automático do valor total
- Detalhes da nota em modal

### Tela de Empresa
- Visualização e edição dos dados da empresa (razão social, CNPJ, endereço, contato)

### Tela de Categorias
- Gerenciamento de categorias de produtos (CRUD)

### Configurações
- Usuários, permissões e tema
- Backup, banco de dados, notificações
- Logs do sistema e análise de atividades

## Tecnologias

### Core
- **Flutter**: Framework de UI multiplataforma
- **Dart 3.10.8+**: Linguagem com null safety e pattern matching (conforme `environment.sdk` no pubspec)
- **Material Design 3**: Sistema de design moderno

### State Management
- **flutter_bloc**: Gerenciamento de estado reativo
- **freezed**: Classes imutáveis para eventos/states

### Persistência
- **drift**: ORM type-safe para SQLite com queries reativas
- **drift_flutter**: Integração Drift com Flutter
- **drift_dev**: Code generation para Drift
- **sqlite3_flutter_libs**: Bibliotecas SQLite nativas
- **json_serializable**: Serialização automática JSON (legacy)
- **synchronized**: Controle de concorrência para JSON (legacy)

### Utilities
- **get_it**: Injeção de dependências (AppInjection)
- **auto_route**: Navegação declarativa type-safe
- **intl**: Internacionalização e formatação de datas/números
- **path_provider**: Acesso a diretórios da aplicação
- **path**: Manipulação de caminhos de arquivos
- **async**: AsyncMemoizer para inicialização única
- **crypto**: Funções criptográficas
- **log_custom_printer**: Log customizado (repositório Git)

## 🏗️ Arquitetura

### Padrões de Design

1. **BLoC Pattern**: Separação clara entre UI e lógica de negócio
2. **Repository Pattern**: Abstração da camada de dados com repositórios
3. **DAO Pattern**: Data Access Objects para acesso ao banco Drift
4. **Dependency Injection**: Gerenciamento de dependências com AppInjection
5. **OperationResult Pattern**: Tratamento type-safe de erros
6. **Interface/Repository**: Contratos em `core/interface/` e implementações em `core/repository/`
7. **Manager Pattern**: Configuração, cache e erros (legacy JSON descontinuado)

### Code Generation

O projeto usa **build_runner** para gerar código automaticamente:

```bash
# Após modificar models, BLoC ou tabelas Drift
dart run build_runner build --delete-conflicting-outputs
```

Gera:
- `.g.dart` - Serialização JSON (@JsonSerializable) e tabelas Drift (@DriftDatabase)
- `.freezed.dart` - Classes imutáveis (@freezed)
- `*.drift.dart` - Queries SQL type-safe do Drift

### Tratamento de Erros

```dart
OperationResult<Cliente, String> resultado = await manager.salvar(cliente);

if (resultado.isSuccessful) {
  final cliente = resultado.asSuccess;
  print('Salvo: ${cliente.name}');
} else {
  final erro = resultado.asError;
  print('Erro: $erro');
}
```

### File Name Safety

Todos os arquivos salvos usam `toSafeFileName()` para garantir compatibilidade cross-platform:

```dart
import 'package:system_loja/core/utils/string_extensions.dart';

final safeFileName = 'Cliente #123.json'.toSafeFileName();
// Resultado: 'Cliente_123.json'
```

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor, leia o [Guia de Contribuição](CONTRIBUTING.md) antes de começar.

### Para Desenvolvedores

1. Fork o repositório
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit suas mudanças: `git commit -m 'feat: adiciona nova feature'`
4. Push para a branch: `git push origin feature/minha-feature`
5. Abra um Pull Request

### Para GitHub Copilot Coding Agent

O projeto está configurado para trabalhar efetivamente com o GitHub Copilot Coding Agent. Consulte:
- [CONTRIBUTING.md](CONTRIBUTING.md) - Guia completo de contribuição
- [.github/copilot-instructions.md](.github/copilot-instructions.md) - Instruções técnicas
- [.github/agents/](.github/agents/) - Custom agents especializados (Flutter Developer, Test Specialist, Documentation Specialist)
- [SETUP_MCP.md](SETUP_MCP.md) - Configuração de servidores MCP (futuro)

### Criando Issues

Use os templates disponíveis:
- **Bug Report**: Para reportar problemas
- **Feature Request**: Para sugerir melhorias

Inclua sempre **critérios de aceitação** claros para facilitar o trabalho do Copilot Agent.

---

## 📖 Documentação

### Guias Principais
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guia de contribuição detalhado
- **[.github/copilot-instructions.md](.github/copilot-instructions.md)** - Instruções para Copilot Agent
- **[.github/agents/](.github/agents/)** - Custom agents (Flutter Developer, Test Specialist, Documentation Specialist)
- **[.github/instructions/dartcode.instructions.md](.github/instructions/dartcode.instructions.md)** - Padrões de código Dart
- **[SETUP_MCP.md](SETUP_MCP.md)** - Informações sobre servidores MCP

### Documentação Técnica
- **[docs/DRIFT_ARCHITECTURE.md](docs/DRIFT_ARCHITECTURE.md)** - Arquitetura Drift ORM
- **[docs/DRIFT_MIGRATION.md](docs/DRIFT_MIGRATION.md)** - Guia de migração para Drift
- **[docs/DATABASE_NORMALIZATION.md](docs/DATABASE_NORMALIZATION.md)** - Normalização do banco de dados
- **[docs/VALIDATION_SYSTEM.md](docs/VALIDATION_SYSTEM.md)** - Sistema de validações
- **[docs/REFACTORING_BLOC.md](docs/REFACTORING_BLOC.md)** - Refatoração BLoC
- **[docs/COMPANY_FEATURE.md](docs/COMPANY_FEATURE.md)** - Funcionalidade de cadastro de empresa
- **[docs/CATEGORY_FEATURE_SUMMARY.md](docs/CATEGORY_FEATURE_SUMMARY.md)** - Resumo da funcionalidade de categorias
- **[docs/CONFIGURACOES_SCREEN.md](docs/CONFIGURACOES_SCREEN.md)** - Tela de configurações
- **[docs/](docs/)** - Documentação adicional do projeto

---

## 📄 Licença

Este projeto é de código aberto. Consulte o arquivo LICENSE para mais detalhes.

---

## 🆘 Suporte

Precisa de ajuda? 
- Abra uma [issue](https://github.com/saulogatti/system_loja/issues) com a label `question`
- Consulte a [documentação](.github/copilot-instructions.md)
- Revise o [guia de contribuição](CONTRIBUTING.md)
