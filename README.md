# System Loja

Sistema de gerenciamento de loja desenvolvido em Flutter com persistência de dados em JSON.

> **🤖 Usando GitHub Copilot?** Leia o [Guia de Contribuição](CONTRIBUTING.md) para obter os melhores resultados!

## 📚 Índice

- [Descrição](#descrição)
- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Como Executar](#como-executar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuindo](#contribuindo)
- [Documentação](#documentação)

## Descrição

Aplicação Flutter com interface gráfica para gerenciamento de loja com as seguintes funcionalidades:

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

- Flutter SDK 3.10 ou superior
- Dart SDK 3.10.1 ou superior (incluído no Flutter)

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

3. Execute o aplicativo:
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

Todos os dados são salvos em formato JSON no diretório `data/`:
- `data/clientes.json` - Dados dos clientes
- `data/produtos.json` - Dados dos produtos
- `data/notas_fiscais.json` - Dados das notas fiscais

## Estrutura do Projeto

```
system_loja/
├── lib/
│   ├── main.dart              # Ponto de entrada do aplicativo Flutter
│   ├── screens/
│   │   ├── home_screen.dart           # Tela inicial com menu
│   │   ├── cliente_screen.dart        # Tela de cadastro de clientes
│   │   ├── produto_screen.dart        # Tela de cadastro de produtos
│   │   └── nota_fiscal_screen.dart    # Tela de cadastro de notas fiscais
│   ├── models/
│   │   ├── cliente.dart       # Modelo de dados Cliente
│   │   ├── produto.dart       # Modelo de dados Produto
│   │   └── nota_fiscal.dart   # Modelo de dados Nota Fiscal
│   ├── managers/
│   │   ├── cliente_manager.dart      # Gerenciador de clientes
│   │   ├── produto_manager.dart      # Gerenciador de produtos
│   │   └── nota_fiscal_manager.dart  # Gerenciador de notas fiscais
│   └── utils/
│       └── input_helper.dart  # Helper para entrada de dados (CLI legacy)
├── data/                      # Diretório para arquivos JSON
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

- **Flutter 3.27**: Framework de UI multiplataforma
- **Dart 3.10.1**: Linguagem de programação
- **Material Design 3**: Sistema de design
- **JSON**: Formato de persistência de dados

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
