# Guia de Teste Manual - Sistema de Validação

Este documento fornece um guia completo para testar manualmente as melhorias de validação implementadas.

## Objetivos dos Testes

Verificar que:
1. Valores negativos são rejeitados em campos numéricos
2. Mensagens de erro são claras e específicas
3. Formatação de entrada funciona corretamente
4. Validação não bloqueia valores válidos
5. Experiência do usuário é intuitiva

## Tela de Produtos

### Cenários de Teste

#### Campo de Preço

**Teste 1: Valores Válidos**
1. Acesse a tela de cadastro de produtos
2. Digite no campo de preço: `10.50`
3. ✅ **Esperado**: Valor aceito
4. Tente também: `10,50`, `100`, `0`, `0.01`
5. ✅ **Esperado**: Todos aceitos

**Teste 2: Valores Inválidos - Negativos**
1. Digite no campo de preço: `-10.50`
2. Tente submeter o formulário
3. ✅ **Esperado**: Mensagem "Preço não pode ser negativo"

**Teste 3: Valores Inválidos - Formato**
1. Digite no campo de preço: `abc`
2. Observe que letras não são digitadas (formatador)
3. ✅ **Esperado**: Apenas números e ponto/vírgula permitidos

**Teste 4: Valores Inválidos - Decimais**
1. Digite no campo de preço: `10.505`
2. Observe que é limitado a `10.50` (formatador)
3. ✅ **Esperado**: Máximo 2 casas decimais

**Teste 5: Conversão de Vírgula**
1. Digite no campo de preço: `10,50`
2. Observe que é convertido para `10.50`
3. ✅ **Esperado**: Vírgula convertida para ponto automaticamente

#### Campo de Estoque

**Teste 6: Valores Válidos**
1. Digite no campo de estoque: `10`
2. ✅ **Esperado**: Valor aceito
3. Tente também: `0`, `100`, `9999`
4. ✅ **Esperado**: Todos aceitos

**Teste 7: Valores Inválidos - Negativos**
1. Tente digitar no campo de estoque: `-10`
2. Observe que o sinal negativo não é aceito (formatador)
3. ✅ **Esperado**: Apenas dígitos permitidos

**Teste 8: Valores Inválidos - Decimais**
1. Tente digitar no campo de estoque: `10.5`
2. Observe que o ponto decimal não é aceito
3. ✅ **Esperado**: Apenas números inteiros permitidos

#### Campo de Código

**Teste 9: Valores Válidos**
1. Digite no campo de código: `ABC-123`
2. ✅ **Esperado**: Valor aceito e convertido para maiúsculas
3. Tente também: `PROD001`, `12345`, `ABC`
4. ✅ **Esperado**: Todos aceitos

**Teste 10: Conversão para Maiúsculas**
1. Digite no campo de código: `abc-123`
2. Observe que é convertido para `ABC-123`
3. ✅ **Esperado**: Conversão automática para maiúsculas

**Teste 11: Valores Inválidos - Caracteres**
1. Tente digitar: `ABC@123`
2. Observe que `@` não é aceito
3. ✅ **Esperado**: Apenas letras, números e hífens permitidos

**Teste 12: Valores Inválidos - Comprimento**
1. Digite apenas: `AB`
2. Tente submeter o formulário
3. ✅ **Esperado**: Mensagem "Código deve ter no mínimo 3 caracteres"

#### Fluxo Completo

**Teste 13: Cadastro Bem-Sucedido**
1. Preencha todos os campos corretamente:
   - Nome: `Notebook Dell`
   - Código: `NOTE-001`
   - Preço: `3500.00`
   - Estoque: `10`
   - Categoria: `Eletrônicos`
   - Descrição: `Notebook Dell Inspiron 15`
2. Clique em "Adicionar Produto"
3. ✅ **Esperado**: Mensagem de sucesso "Produto 'Notebook Dell' cadastrado com sucesso!"
4. ✅ **Esperado**: Formulário limpo
5. ✅ **Esperado**: Produto aparece na lista

## Tela de Vendas

### Cenários de Teste

#### Campo de Quantidade

**Teste 14: Quantidade Válida**
1. Acesse a tela de vendas
2. Clique em "Adicionar Item"
3. Selecione um produto com estoque de 10 unidades
4. Digite quantidade: `5`
5. ✅ **Esperado**: Item adicionado com sucesso

**Teste 15: Quantidade Inválida - Negativa**
1. Tente adicionar item
2. Tente digitar: `-5`
3. Observe que sinal negativo não é aceito
4. ✅ **Esperado**: Apenas números positivos permitidos

**Teste 16: Quantidade Inválida - Estoque**
1. Tente adicionar item de produto com estoque de 5
2. Digite quantidade: `10`
3. Tente confirmar
4. ✅ **Esperado**: Mensagem "Quantidade maior que o estoque disponível"

**Teste 17: Quantidade Inválida - Decimal**
1. Tente digitar: `5.5`
2. Observe que ponto decimal não é aceito
3. ✅ **Esperado**: Apenas números inteiros permitidos

#### Campos de Nota Fiscal

**Teste 18: Campos Obrigatórios**
1. Tente salvar nota fiscal sem preencher campos
2. ✅ **Esperado**: Mensagens de erro específicas para cada campo vazio

**Teste 19: Validação de Cliente**
1. Preencha número da nota e forma de pagamento
2. Não selecione cliente
3. Tente salvar
4. ✅ **Esperado**: Mensagem "Erro: Selecione um cliente!"

**Teste 20: Validação de Itens**
1. Preencha todos os campos mas não adicione itens
2. Tente salvar
3. ✅ **Esperado**: Mensagem "Erro: Adicione pelo menos um item!"

## Tela de Clientes

### Cenários de Teste

**Teste 21: Nome Válido**
1. Digite nome: `João Silva`
2. ✅ **Esperado**: Aceito (>= 3 caracteres)

**Teste 22: Nome Inválido - Muito Curto**
1. Digite nome: `Jo`
2. Tente submeter
3. ✅ **Esperado**: Mensagem "Nome deve ter no mínimo 3 caracteres"

**Teste 23: Nome Vazio**
1. Deixe campo de nome vazio
2. Tente submeter
3. ✅ **Esperado**: Mensagem "Nome é obrigatório"

## Tela de Usuários

### Cenários de Teste

**Teste 24: Nome Válido**
1. Digite nome: `Maria Santos`
2. ✅ **Esperado**: Aceito (>= 3 caracteres)

**Teste 25: Nome Inválido - Muito Curto**
1. Digite nome: `Ma`
2. Tente submeter
3. ✅ **Esperado**: Mensagem "Nome deve ter no mínimo 3 caracteres"

## Testes de Integração

### Fluxo Completo de Venda

**Teste 26: Venda Completa**
1. Cadastre um produto com estoque de 10
2. Cadastre um cliente
3. Crie uma nota fiscal
4. Adicione o produto com quantidade 5
5. Salve a nota fiscal
6. ✅ **Esperado**: Venda registrada com sucesso
7. Verifique o estoque do produto
8. ✅ **Esperado**: Estoque reduzido para 5

## Testes de Regressão

**Teste 27: Funcionalidades Existentes**
1. Teste todas as funcionalidades existentes (listar, editar, excluir)
2. ✅ **Esperado**: Nenhuma funcionalidade quebrada

## Checklist de Validação

Use este checklist para garantir que todos os testes foram realizados:

### Produtos
- [ ] Preço aceita valores positivos
- [ ] Preço rejeita valores negativos
- [ ] Preço limita a 2 casas decimais
- [ ] Preço converte vírgula para ponto
- [ ] Estoque aceita inteiros positivos
- [ ] Estoque rejeita negativos
- [ ] Estoque rejeita decimais
- [ ] Código aceita alfanuméricos e hífens
- [ ] Código converte para maiúsculas
- [ ] Código rejeita caracteres especiais
- [ ] Código valida comprimento mínimo/máximo

### Vendas
- [ ] Quantidade aceita inteiros positivos
- [ ] Quantidade rejeita negativos
- [ ] Quantidade rejeita decimais
- [ ] Quantidade valida contra estoque
- [ ] Campos obrigatórios são validados
- [ ] Validação de cliente funciona
- [ ] Validação de itens funciona

### Clientes
- [ ] Nome valida comprimento mínimo
- [ ] Nome valida obrigatoriedade

### Usuários
- [ ] Nome valida comprimento mínimo
- [ ] Nome valida obrigatoriedade

### Geral
- [ ] Mensagens de erro são claras e específicas
- [ ] Helper text orienta o usuário
- [ ] Formatadores previnem entrada inválida
- [ ] Validadores capturam erros
- [ ] Formulários não permitem submissão com erros
- [ ] Experiência do usuário é intuitiva

## Relatando Problemas

Se encontrar algum problema durante os testes, reporte com:

1. **Tela**: Qual tela foi afetada
2. **Campo**: Qual campo apresentou o problema
3. **Ação**: O que você tentou fazer
4. **Esperado**: O que deveria acontecer
5. **Obtido**: O que realmente aconteceu
6. **Passos para Reproduzir**: Como recriar o problema

## Notas Importantes

1. Todos os formatadores funcionam em tempo real - caracteres inválidos simplesmente não aparecem no campo
2. Validadores são executados ao tentar submeter o formulário
3. Mensagens de erro aparecem abaixo do campo correspondente
4. Helper text fornece exemplos de formato correto
5. Campos obrigatórios são marcados com asterisco (*)

## Ambiente de Teste

Teste em múltiplas plataformas quando possível:
- [ ] Windows
- [ ] macOS
- [ ] iOS
- [ ] Android

## Conclusão

Após completar todos os testes deste guia, você terá verificado que:
- ✅ Valores negativos são corretamente rejeitados
- ✅ Formatação de entrada funciona adequadamente
- ✅ Mensagens de erro são específicas e úteis
- ✅ Validação não interfere com uso normal
- ✅ Sistema é mais robusto e confiável
