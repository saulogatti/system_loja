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
- **Persistência Dual**: JSON (legacy) + SQLite (novo)
- **Code Generation**: `json_serializable`, `freezed`, `build_runner`
- **Padrões**: Repository Pattern, Manager Pattern, OperationResult
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

## Requisitos

- Flutter SDK 3.27 ou superior
- Dart SDK 3.10.1 ou superior (incluído no Flutter)
- SQLite (incluído no Flutter desktop)

## Como Instalar o Flutter

### Linux/macOS
```bash
# Baixe o Flutter SDK
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz
tar xf flutter_linux_3.27.1-stable.tar.xz
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

### Sistema Legacy (JSON)
- `data/clientes.json` - Dados dos clientes
- `data/produtos.json` - Dados dos produtos
- `data/notas_fiscais.json` - Dados das notas fiscais
- Gerenciadores em `lib/core/managers/`

### Sistema Novo (SQLite)
- Banco: `system_loja.db` (criado automaticamente)
- Tabelas: `clientes`, `produtos`, `notas_fiscais`, `itens_nota_fiscal`
- Managers em `lib/data/database/`
- Suporte a transações e relacionamentos

## Estrutura do Projeto

```
system_loja/
├── lib/
│   ├── main.dart              # Ponto de entrada com Material 3
│   ├── core/
│   │   ├── models/            # Modelos com @JsonSerializable
│   │   │   ├── customer.dart  # Customer (Cliente)
│   │   │   ├── produto.dart   # Produto
│   │   │   └── nota_fiscal.dart
│   │   ├── managers/          # Managers JSON (legacy)
│   │   │   ├── cliente_manager.dart
│   │   │   ├── produto_manager.dart
│   │   │   └── nota_fiscal_manager.dart
│   │   └── utils/
│   │       ├── command_result.dart     # OperationResult pattern
│   │       └── string_extensions.dart  # File name safety
│   ├── data/
│   │   ├── database/          # SQL Managers (novo)
│   │   │   ├── database_helper.dart
│   │   │   ├── cliente_sql_manager.dart
│   │   │   ├── produto_sql_manager.dart
│   │   │   └── nota_fiscal_sql_manager.dart
│   │   ├── cache/             # Sistema de cache
│   │   │   └── cache_manager.dart
│   │   └── files_system/      # File operations
│   │       └── file_system_helper.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── customer/
│   │   │   ├── customer_view.dart
│   │   │   └── bloc/          # BLoC com freezed
│   │   │       ├── customer_bloc.dart
│   │   │       ├── customer_bloc_event.dart
│   │   │       └── customer_bloc_state.dart
│   │   ├── produto_screen.dart
│   │   └── nota_fiscal_screen.dart
│   └── utils/
│       └── input_helper.dart  # CLI legacy
├── test/                      # Testes unitários e integração
├── data/                      # Arquivos JSON (legacy)
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

## Tecnologias

### Core
- **Flutter 3.38**: Framework de UI multiplataforma
- **Dart 3.10.1**: Linguagem com null safety e pattern matching
- **Material Design 3**: Sistema de design moderno

### State Management
- **flutter_bloc**: Gerenciamento de estado reativo
- **freezed**: Classes imutáveis para eventos/states

### Persistência
- **sqflite**: Banco de dados SQLite
- **sqflite_common_ffi**: Suporte SQLite para desktop
- **json_serializable**: Serialização automática JSON
- **synchronized**: Controle de concorrência para JSON

### Utilities
- **path_provider**: Acesso a diretórios da aplicação
- **path**: Manipulação de caminhos de arquivos
- **async**: AsyncMemoizer para inicialização única

## 🏗️ Arquitetura

### Padrões de Design

1. **BLoC Pattern**: Separação clara entre UI e lógica de negócio
2. **Repository Pattern**: Abstração da camada de dados (SQL managers)
3. **Manager Pattern**: Gerenciamento de dados JSON (legacy)
4. **OperationResult Pattern**: Tratamento type-safe de erros
5. **Mixin Pattern**: Reutilização de código (FileSystemManager)

### Code Generation

O projeto usa **build_runner** para gerar código automaticamente:

```bash
# Após modificar models ou BLoC
dart run build_runner build --delete-conflicting-outputs
```

Gera:
- `.g.dart` - Serialização JSON (@JsonSerializable)
- `.freezed.dart` - Classes imutáveis (@freezed)

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
- [SETUP_MCP.md](SETUP_MCP.md) - Configuração de servidores MCP (futuro)

### Criando Issues

Use os templates disponíveis:
- **Bug Report**: Para reportar problemas
- **Feature Request**: Para sugerir melhorias

Inclua sempre **critérios de aceitação** claros para facilitar o trabalho do Copilot Agent.

---

## 📖 Documentação

- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guia de contribuição detalhado
- **[.github/copilot-instructions.md](.github/copilot-instructions.md)** - Instruções para Copilot Agent
- **[.github/instructions/dartcode.instructions.md](.github/instructions/dartcode.instructions.md)** - Padrões de código Dart
- **[SETUP_MCP.md](SETUP_MCP.md)** - Informações sobre servidores MCP
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
