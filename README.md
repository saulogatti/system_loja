# System Loja

Sistema de gerenciamento de loja desenvolvido em Dart com persistência de dados em JSON.

## Descrição

Sistema CLI (Command Line Interface) para gerenciamento de loja com as seguintes funcionalidades:

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

- Dart SDK 3.10.1 ou superior

## Como Instalar o Dart

### Linux/macOS
```bash
# Usando Homebrew (macOS)
brew tap dart-lang/dart
brew install dart

# Ou baixe diretamente
wget https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
unzip dartsdk-linux-x64-release.zip
export PATH="$PATH:/path/to/dart-sdk/bin"
```

### Windows
Baixe o instalador em: https://dart.dev/get-dart

## Como Executar

1. Clone o repositório:
```bash
git clone https://github.com/saulogatti/system_loja.git
cd system_loja
```

2. Execute o sistema:
```bash
dart run
```

## Estrutura de Dados

Todos os dados são salvos em formato JSON no diretório `data/`:
- `data/clientes.json` - Dados dos clientes
- `data/produtos.json` - Dados dos produtos
- `data/notas_fiscais.json` - Dados das notas fiscais

## Estrutura do Projeto

```
system_loja/
├── bin/
│   └── system_loja.dart       # Ponto de entrada do sistema
├── lib/
│   ├── system_loja.dart       # Biblioteca principal
│   ├── models/
│   │   ├── cliente.dart       # Modelo de dados Cliente
│   │   ├── produto.dart       # Modelo de dados Produto
│   │   └── nota_fiscal.dart   # Modelo de dados Nota Fiscal
│   ├── managers/
│   │   ├── cliente_manager.dart      # Gerenciador de clientes
│   │   ├── produto_manager.dart      # Gerenciador de produtos
│   │   └── nota_fiscal_manager.dart  # Gerenciador de notas fiscais
│   └── utils/
│       └── input_helper.dart  # Helper para entrada de dados
├── data/                      # Diretório para arquivos JSON
├── pubspec.yaml
└── README.md
```

## Exemplo de Uso

1. Selecione a opção 1 para cadastrar um cliente
2. Selecione a opção 2 para cadastrar produtos
3. Selecione a opção 3 para criar uma nota fiscal de compra
4. Selecione a opção 4 para sair do sistema

## Tecnologias

- **Dart 3.10.1**: Linguagem de programação
- **JSON**: Formato de persistência de dados
