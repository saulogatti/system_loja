# Widget de Categoria de Produto

## Visão Geral

O `ProductCategory` é um widget reutilizável que facilita a seleção e criação de categorias de produtos. Ele oferece duas formas de interação:

1. **Modo Dropdown**: Permite selecionar uma categoria existente de uma lista
2. **Modo Manual**: Permite digitar uma nova categoria personalizada

## Funcionalidades

### Seleção Inteligente
- Extrai automaticamente categorias únicas dos produtos existentes
- Ordena as categorias alfabeticamente
- Ignora categorias vazias

### Alternância de Modos
- Inicia no modo dropdown se houver categorias cadastradas
- Botão **+** (adicionar) alterna para modo de entrada manual
- Botão **☰** (lista) retorna ao modo dropdown
- Preserva o valor do controller durante alternância

### Validação
- Suporta validação de campo obrigatório via parâmetro `required`
- Mensagens de erro apropriadas para cada modo
- Integração com `Form` do Flutter

### Controle de Estado
- Sincroniza automaticamente com o `TextEditingController`
- Atualiza lista de categorias quando produtos mudam
- Inicializa com valor pré-existente do controller

### Acessibilidade
- Suporta habilitação/desabilitação via parâmetro `enabled`
- Callback `onChanged` para reagir a mudanças de categoria
- Tooltips descritivos nos botões de ação

## Uso

### Exemplo Básico

```dart
final categoriaController = TextEditingController();
final produtos = [...]; // Lista de produtos existentes

ProductCategory(
  controller: categoriaController,
  produtos: produtos,
)
```

### Com Validação Obrigatória

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  required: true,
)
```

### Com Callback de Mudança

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  onChanged: (novaCategoria) {
    print('Categoria alterada para: $novaCategoria');
  },
)
```

### Em Modo Somente Leitura

```dart
ProductCategory(
  controller: categoriaController,
  produtos: produtos,
  enabled: false,
)
```

## Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|-----------|------|-------------|-----------|
| `controller` | `TextEditingController` | Sim | Controller para gerenciar o texto da categoria |
| `produtos` | `List<Produto>` | Sim | Lista de produtos para extrair categorias existentes |
| `required` | `bool` | Não | Se `true`, valida que o campo não está vazio (padrão: `false`) |
| `enabled` | `bool` | Não | Se `false`, desabilita o campo (padrão: `true`) |
| `onChanged` | `ValueChanged<String?>?` | Não | Callback chamado quando a categoria é alterada |

## Integração

### ProductForm

O widget está integrado ao `ProductForm`, substituindo o `TextFormField` original para categorias:

```dart
ProductForm(
  // ... outros parâmetros
  categoriaController: _categoriaController,
  produtos: produtos, // Lista de produtos do estado BLoC
)
```

### ProductDetailScreen

Também está integrado ao `ProductDetailScreen` para edição de produtos:

```dart
ProductCategory(
  controller: _categoriaController,
  produtos: produtos, // Lista do BLoC state
  enabled: _isEditing, // Habilitado apenas em modo edição
)
```

## Comportamento Detalhado

### Inicialização
- Se não há produtos, exibe campo de texto
- Se há produtos mas controller está vazio, exibe dropdown
- Se controller tem valor que existe nas categorias, exibe dropdown com valor selecionado
- Se controller tem valor que não existe nas categorias, exibe campo de texto com o valor

### Extração de Categorias
1. Percorre todos os produtos na lista
2. Extrai o campo `categoria` de cada produto
3. Filtra categorias vazias
4. Remove duplicatas
5. Ordena alfabeticamente

### Alternância de Modo
**Dropdown → Manual:**
- Limpa seleção do dropdown
- Mantém valor do controller (se houver)

**Manual → Dropdown:**
- Limpa o controller
- Reseta para estado inicial do dropdown

## Testes

O widget possui 18 testes automatizados que cobrem:
- Exibição condicional (dropdown vs campo de texto)
- Extração de categorias únicas
- Seleção de categorias
- Alternância entre modos
- Validação de campos obrigatórios
- Habilitação/desabilitação
- Callbacks de mudança
- Inicialização com valores
- Atualização dinâmica de categorias

Para executar os testes:
```bash
flutter test test/product_category_widget_test.dart
```

## Design Pattern

O widget segue os padrões estabelecidos no projeto:
- Documentação completa em português
- Uso de Material 3 design
- Integração com BLoC para gerenciamento de estado
- Validação consistente com outros widgets do formulário
- Separação de responsabilidades (widget separado, não inline)

## Melhorias Futuras

Possíveis melhorias que podem ser implementadas:
1. Autocomplete com sugestões enquanto digita
2. Ícones personalizados por categoria
3. Cores customizáveis por categoria
4. Histórico de categorias mais usadas
5. Busca/filtro de categorias quando há muitas opções
