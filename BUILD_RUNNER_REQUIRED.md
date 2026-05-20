# Build Runner Required

## ⚠️ ATENÇÃO: Code Generation Necessária

Após as mudanças realizadas neste PR, é **OBRIGATÓRIO** executar o comando de geração de código:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## O que foi alterado

1. **CustomerView** agora aceita um parâmetro opcional `Customer? customer` para suportar modo de edição
2. **CustomerDetailScreen** foi removido - agora usamos CustomerView para ambos adicionar e editar
3. **CustomerDetailRoute** foi removido do `route_app.dart`
4. O **auto_route** precisa regenerar o arquivo `route_app.gr.dart` para refletir essas mudanças

## Por que precisa executar

O arquivo `lib/screens/route/route_app.gr.dart` é gerado automaticamente pelo `auto_route_generator` e precisa ser regenerado para:

1. Remover a classe `CustomerDetailRoute`
2. Remover a classe `CustomerDetailRouteArgs`
3. Atualizar a classe `CustomerRoute` para aceitar um parâmetro opcional `customer`
4. Atualizar todos os imports e referências

## Como executar

No diretório raiz do projeto, execute:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## O que esperar

Após executar, você verá mensagens como:

```text
[INFO] Generating build script completed, took 234ms
[INFO] Creating build script snapshot... completed, took 8.7s
[INFO] Building new asset graph completed, took 1.2s
[INFO] Checking for unexpected pre-existing outputs completed, took 1ms
[INFO] Running build completed, took 15.2s
[INFO] Caching finalized dependency graph completed, took 45ms
[INFO] Succeeded after 15.3s with 2 outputs
```

## Após a execução

Verifique que o arquivo `lib/screens/route/route_app.gr.dart` foi atualizado:

- ✅ Não deve mais conter `CustomerDetailRoute`
- ✅ Não deve mais conter `CustomerDetailRouteArgs`  
- ✅ `CustomerRoute` deve aceitar parâmetro opcional `customer`
- ✅ Import de `customer_detail_screen.dart` deve ter sido removido

Commit o arquivo gerado junto com as outras mudanças.
