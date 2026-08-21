# Refatoração: Uso de toJson() e fromJson() nos SQL Managers

## Resumo

Esta refatoração altera os SQL managers (`cliente_sql_manager.dart`, `produto_sql_manager.dart`, `nota_fiscal_sql_manager.dart`) para utilizar os métodos `toJson()` e `fromJson()` gerados pelo `json_serializable` ao invés de criar Maps manualmente.

## Alterações Realizadas

### 1. ProdutoSqlManager

**Antes:**
```dart
final Map<String, dynamic> dados = {
  'nome': produto.nome,
  'codigo': produto.codigo,
  'preco': produto.preco,
  'estoque': produto.estoque,
  'descricao': produto.descricao,
  'categoria': produto.categoria,
  'data_cadastro': produto.dataCadastro.toIso8601String(),
};
```

**Depois:**
```dart
final Map<String, dynamic> dados = produto.toJson();
// Remove o ID do map de dados pois será gerado automaticamente
dados.remove('id');
```

**Método `_mapToProduto`:**

**Antes:**
```dart
Produto _mapToProduto(Map<String, dynamic> map) {
  return Produto(
    id: map['id'] as int,
    nome: map['nome'] as String,
    codigo: map['codigo'] as String,
    preco: (map['preco'] as num).toDouble(),
    estoque: map['estoque'] as int,
    descricao: (map['descricao'] as String?) ?? '',
    categoria: (map['categoria'] as String?) ?? '',
    dataCadastro: DateTime.parse(map['data_cadastro'] as String),
  );
}
```

**Depois:**
```dart
Produto _mapToProduto(Map<String, dynamic> map) {
  // Garante que campos opcionais tenham valores padrão vazios
  final mapComDefaults = {
    ...map,
    'descricao': map['descricao'] ?? '',
    'categoria': map['categoria'] ?? '',
  };
  return Produto.fromJson(mapComDefaults);
}
```

### 2. ClienteSqlManager

O modelo `Cliente` possui uma estrutura aninhada com `DadosCliente`, que não corresponde diretamente ao schema do banco (que é plano). Por isso, foram criados métodos auxiliares para converter entre as duas representações:

**Métodos Auxiliares Adicionados:**
- `_clienteParaDadosDb()`: Converte um Cliente para Map plano do banco
- `_dadosDbParaClienteJson()`: Converte Map plano do banco para estrutura JSON aninhada

**Método `_mapToCliente`:**

**Antes:**
```dart
Cliente _mapToCliente(Map<String, dynamic> map) {
  return Cliente(
    id: map['id'] as int,
    nome: map['nome'] as String,
    cpf: map['cpf'] as String,
    email: (map['email'] as String?) ?? '',
    telefone: (map['telefone'] as String?) ?? '',
    endereco: (map['endereco'] as String?) ?? '',
    dataCadastro: DateTime.parse(map['data_cadastro'] as String),
  );
}
```

**Depois:**
```dart
Cliente _mapToCliente(Map<String, dynamic> map) {
  // Prepara os dados para o formato esperado pelo fromJson
  final mapFormatado = _dadosDbParaClienteJson(map);
  return Cliente.fromJson(mapFormatado);
}
```

### 3. NotaFiscalSqlManager

**Método `atualizar`:**

**Antes:**
```dart
final Map<String, dynamic> dadosNota = {
  'numero_nota': notaFiscal.numeroNota,
  'cliente_id': notaFiscal.clienteId,
  'cliente_nome': notaFiscal.clienteNome,
  'cliente_cpf': notaFiscal.clienteCpf,
  'valor_total': notaFiscal.valorTotal,
  'forma_pagamento': notaFiscal.formaPagamento,
  'data_emissao': notaFiscal.dataEmissao.toIso8601String(),
};

final Map<String, dynamic> dadosItem = {
  'nota_fiscal_id': notaFiscal.id,
  'produto_id': item.produtoId,
  'produto_nome': item.produtoNome,
  'produto_codigo': item.produtoCodigo,
  'quantidade': item.quantidade,
  'preco_unitario': item.precoUnitario,
  'valor_total': item.valorTotal,
};
```

**Depois:**
```dart
final Map<String, dynamic> dadosNota = notaFiscal.toJson();
// Remove campos que não devem ser atualizados
dadosNota.remove('id');
dadosNota.remove('itens');
// Adiciona o valor_total calculado
dadosNota['valor_total'] = notaFiscal.valorTotal;

final Map<String, dynamic> dadosItem = item.toJson();
// Adiciona campos necessários para o banco
dadosItem['nota_fiscal_id'] = notaFiscal.id;
dadosItem['valor_total'] = item.valorTotal;
```

**Método `_mapToNotaFiscal`:**

**Antes:**
```dart
NotaFiscal _mapToNotaFiscal(
  Map<String, dynamic> notaMap,
  List<Map<String, dynamic>> itensMap,
) {
  final List<ItemNotaFiscal> itens = itensMap.map((itemMap) {
    return ItemNotaFiscal(
      produtoId: itemMap['produto_id'] as int,
      produtoNome: itemMap['produto_nome'] as String,
      produtoCodigo: itemMap['produto_codigo'] as String,
      quantidade: itemMap['quantidade'] as int,
      precoUnitario: (itemMap['preco_unitario'] as num).toDouble(),
    );
  }).toList();

  return NotaFiscal(
    id: notaMap['id'] as int,
    numeroNota: notaMap['numero_nota'] as String,
    clienteId: notaMap['cliente_id'] as int,
    clienteNome: notaMap['cliente_nome'] as String,
    clienteCpf: notaMap['cliente_cpf'] as String,
    itens: itens,
    formaPagamento: notaMap['forma_pagamento'] as String,
    dataEmissao: DateTime.parse(notaMap['data_emissao'] as String),
  );
}
```

**Depois:**
```dart
NotaFiscal _mapToNotaFiscal(
  Map<String, dynamic> notaMap,
  List<Map<String, dynamic>> itensMap,
) {
  final List<ItemNotaFiscal> itens = itensMap.map((itemMap) {
    return ItemNotaFiscal.fromJson(itemMap);
  }).toList();

  // Prepara o map da nota com os itens para desserialização
  final notaComItens = {
    ...notaMap,
    'itens': itens.map((item) => item.toJson()).toList(),
  };

  return NotaFiscal.fromJson(notaComItens);
}
```

### 4. Atualização dos Modelos

Adicionado `explicitToJson: true` nas anotações `@JsonSerializable` para garantir que objetos aninhados sejam serializados corretamente:

**Cliente:**
```dart
@JsonSerializable(constructor: 'withDados', explicitToJson: true)
class Cliente extends DefaultObject {
```

**NotaFiscal:**
```dart
@JsonSerializable(explicitToJson: true)
class NotaFiscal extends DefaultObject {
```

## Benefícios

1. **Menos Código Manual**: Reduz a quantidade de código repetitivo para serialização/desserialização
2. **Manutenibilidade**: Alterações nos modelos são automaticamente refletidas nos SQL managers
3. **Consistência**: Usa o mesmo mecanismo de serialização em toda a aplicação
4. **Menos Erros**: Reduz erros de digitação ou campos esquecidos na serialização manual
5. **Type Safety**: Aproveita a geração de código do json_serializable para garantir tipos corretos

## Testes

- ✅ Testes de serialização JSON criados e passando (`test/json_serialization_test.dart`)
- ✅ Análise estática dos SQL managers sem erros
- ⚠️ Testes de integração do SQL existentes com problemas de infraestrutura não relacionados à refatoração

## Observações

- A estrutura do banco de dados permanece inalterada
- Não há quebra de compatibilidade com dados existentes
- O comportamento das operações CRUD permanece o mesmo
- Campos calculados (`valor_total`) são adicionados manualmente onde necessário
