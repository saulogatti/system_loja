---
description: Instruções para agentes implementarem features e correções no System Loja
applyTo: '**'
---

# Instruções para Agentes de Implementação - System Loja

Este documento fornece diretrizes claras e detalhadas para agentes de IA implementarem features, correções de bugs e melhorias no projeto System Loja.

## 1. Contexto Arquitetural

### 1.1 Stack Tecnológico
- **Framework**: Flutter (multiplatforma: Windows, macOS, iOS, Android)
- **Persistência Dual**: 
  - JSON (legado): `lib/core/managers/`
  - SQLite (novo): `lib/data/database/` e `lib/data/storage/`
- **State Management**: BLoC com `flutter_bloc` e `freezed`
- **Design**: Material 3 com componentes modernos
- **Serialização**: `json_serializable` com `@JsonSerializable`

### 1.2 Estrutura de Diretórios Crítica
```
lib/
├── core/
│   ├── managers/          # Managers JSON (legado)
│   ├── models/            # Data classes com @JsonSerializable
│   └── utils/             # Utilitários e extensões
├── data/
│   ├── cache/             # Sistema de cache genérico
│   ├── database/          # Managers SQLite (novo padrão)
│   ├── files_system/      # Operações de arquivos
│   └── storage/           # Armazenamento genérico
├── screens/
│   ├── home_screen.dart   # Tela principal
│   ├── cliente_screen/    # Exemplo: Cliente com BLoC
│   ├── produto_screen/    # Exemplo: Produto com BLoC
│   └── */bloc/            # BLoC para cada entidade
└── main.dart              # Entry point
```

## 2. Padrões Obrigatórios

### 2.1 Tratamento de Erros: OperationResult Pattern
**SEMPRE** use `OperationResult<T, E>` sealed class para operações assíncronas:

```dart
import 'package:system_loja/core/utils/command_result.dart';

// Retornar resultado
Future<OperationResult<Cliente, String>> buscarCliente(int id) async {
  try {
    final cliente = await database.buscar(id);
    if (cliente == null) {
      return OperationFailure(error: 'Cliente com ID $id não encontrado');
    }
    return OperationSuccess(value: cliente);
  } catch (e) {
    return OperationFailure(error: 'Erro ao buscar cliente: $e');
  }
}

// Consumir resultado
final resultado = await buscarCliente(1);
switch (resultado) {
  case OperationSuccess(value: final cliente):
    print('Cliente: ${cliente.nome}');
  case OperationFailure(error: final erro):
    print('Erro: $erro');
}
```

### 2.2 Modelos com Serialização JSON
**OBRIGATÓRIO**: Todos os models devem usar `@JsonSerializable` em `lib/core/models/`:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'cliente.g.dart'; // CRÍTICO: declarar parte gerada

@JsonSerializable()
class Cliente {
  /// ID único do cliente (nulo para novos registros).
  final int? id;
  
  /// Nome completo do cliente.
  final String nome;
  
  /// CPF no formato sem formatação (apenas dígitos).
  final String cpf;

  const Cliente({
    this.id,
    required this.nome,
    required this.cpf,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);
  
  Map<String, dynamic> toJson() => _$ClienteToJson(this);
}
```

**APÓS MODIFICAR MODELS**: Executar build runner:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 2.3 BLoC com Freezed para State Management
Criar em `lib/screens/[entidade]/bloc/`:

**[entidade]_bloc_event.dart**:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[entidade]_bloc_event.freezed.dart';

@freezed
sealed class [Entidade]BlocEvent with _$[Entidade]BlocEvent {
  const factory [Entidade]BlocEvent.salvar({
    required String nome,
  }) = _Salvar;
  
  const factory [Entidade]BlocEvent.deletar({
    required int id,
  }) = _Deletar;
  
  const factory [Entidade]BlocEvent.listar() = _Listar;
}
```

**[entidade]_bloc_state.dart**:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/[entidade].dart';

part '[entidade]_bloc_state.freezed.dart';

@freezed
sealed class [Entidade]BlocState with _$[Entidade]BlocState {
  const factory [Entidade]BlocState.inicial() = _Inicial;
  
  const factory [Entidade]BlocState.carregando() = _Carregando;
  
  const factory [Entidade]BlocState.sucesso({
    required List<[Entidade]> lista,
  }) = _Sucesso;
  
  const factory [Entidade]BlocState.erro({
    required String mensagem,
  }) = _Erro;
}
```

**[entidade]_bloc.dart**:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/[entidade].dart';
import 'package:system_loja/core/managers/[entidade]_manager.dart';

class [Entidade]Bloc extends Bloc<[Entidade]BlocEvent, [Entidade]BlocState> {
  final [Entidade]Manager manager;

  [Entidade]Bloc({required this.manager}) 
      : super(const [Entidade]BlocState.inicial()) {
    on<_Salvar>((event, emit) async {
      // Implementação
    });
    on<_Deletar>((event, emit) async {
      // Implementação
    });
    on<_Listar>((event, emit) async {
      // Implementação
    });
  }
}
```

### 2.4 Documentação em Português
**OBRIGATÓRIO**: Documentar em português usando `///` para:
- Todas as classes públicas e privadas
- Todos os métodos públicos
- Parâmetros complexos
- Comportamentos não óbvios

```dart
/// Gerencia operações CRUD para clientes no banco SQLite.
///
/// Implementa o padrão Repository com sincronização automática
/// entre cache em memória e banco de dados.
class ClienteRepository {
  /// Insere um novo cliente ou atualiza existente.
  ///
  /// Retorna [OperationSuccess] com o cliente salvo (com ID atualizado)
  /// ou [OperationFailure] se houver erro de validação/banco.
  /// 
  /// Lança [ClienteException] se o CPF já estiver cadastrado.
  Future<OperationResult<Cliente, String>> salvar(Cliente cliente) async {
    // Implementação
  }
}
```

### 2.5 Segurança de Nomes de Arquivo
Usar extensão `FileNameStringExtensions` ao salvar arquivos:

```dart
import 'package:system_loja/core/utils/string_extensions.dart';

// Seguro para todos os sistemas operacionais
final nomeSeguro = 'Cliente 123 - Pedido#456.json'.toSafeFileName();
// Resultado: 'cliente_123_-_pedido456.json'

// Validação
if ('meu_arquivo.json'.isValidFileName()) {
  // Safe to use
}

// Métodos disponíveis
fileName.sanitizeFileName()      // Remove caracteres inválidos
fileName.truncateFileName(200)   // Limita comprimento
fileName.toAsciiFileName()       // Remove acentos
fileName.isReservedFileName()    // Valida nomes Windows reservados
```

### 2.6 Concorrência em Managers JSON (Legado)
Se modificar managers em `lib/core/managers/`:

```dart
import 'package:synchronized/synchronized.dart';

class [Entidade]Manager {
  static final Map<String, Lock> _fileLocks = {};
  
  /// Obtém lock para sincronização.
  Lock _getLock() {
    return _fileLocks.putIfAbsent(
      'chave_unica',
      () => Lock(),
    );
  }

  /// Salva com segurança thread-safe.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      // 1. Carregar dados atualizados do disco
      final dadosAtuais = _carregarDadosDoDisco();
      // 2. Mesclar mudanças
      // 3. Salvar atomicamente
    });
  }
}
```

## 3. Workflow de Desenvolvimento

### 3.1 Adicionar Nova Feature com BLoC
1. **Model**: Criar em `lib/core/models/entidade.dart` com `@JsonSerializable`
2. **Manager/Repository**: Criar operações CRUD em `lib/core/managers/` ou `lib/data/database/`
3. **BLoC**: Criar em `lib/screens/entidade/bloc/` com eventos e estados `@freezed`
4. **Build Runner**: Executar `dart run build_runner build --delete-conflicting-outputs`
5. **Screen**: Criar em `lib/screens/entidade/entidade_screen.dart` com `BlocProvider` e `BlocBuilder`
6. **Navegação**: Adicionar card em `lib/screens/home_screen.dart`
7. **Testes**: Criar testes unitários em `test/`

### 3.2 Adicionar Operação ao BLoC Existente
1. Adicionar novo evento em `*_bloc_event.dart` com `@freezed`
2. Adicionar novo estado em `*_bloc_state.dart` com `@freezed`
3. Registrar handler em construtor do BLoC: `on<NovoEvento>((event, emit) async { ... })`
4. Executar build runner
5. Implementar lógica de negócio
6. Adicionar testes

### 3.3 Migrar de JSON para SQLite
Para entidades em `lib/core/managers/`:

1. Criar SQL Manager em `lib/data/database/[entidade]_sql_manager.dart`
2. Criar tests comparativos: `test/[entidade]_migration_test.dart`
3. Manter JSON Manager para compatibilidade (deprecated)
4. Atualizar importações em BLoC/Screen gradualmente
5. Documentar migração em `docs/`

## 4. Convenções de Código

### 4.1 Nomenclatura
- **Classes**: `UpperCamelCase` (ex: `ClienteManager`, `SalesScreen`)
- **Métodos/Variáveis**: `lowerCamelCase` (ex: `buscarCliente()`, `isActive`)
- **Constantes**: `lowerCamelCase` ou `UPPER_SNAKE_CASE` para globais
- **Arquivos**: `lowercase_with_underscores` (ex: `cliente_manager.dart`)
- **Imports**: `dart:` → `package:` → relativos, alfabética

### 4.2 Estrutura de Classe
```dart
class MinhaClasse {
  // 1. Static + constantes
  static const String exemplo = 'valor';
  
  // 2. Campos
  final String nome;
  late final String descricao;
  
  // 3. Construtores
  const MinhaClasse({required this.nome});
  
  // 4. Named constructors
  factory MinhaClasse.vazio() => MinhaClasse(nome: '');
  
  // 5. Getters
  bool get estaVazio => nome.isEmpty;
  
  // 6. Métodos
  void processar() { }
  
  // 7. Overrides
  @override
  String toString() => 'MinhaClasse($nome)';
}
```

## 5. Testes Obrigatórios

### 5.1 Estrutura de Testes
Criar em `test/` com padrão: `[entidade]_[tipo]_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/cliente.dart';

void main() {
  group('Cliente', () {
    test('serialização JSON roundtrip', () {
      final cliente = Cliente(id: 1, nome: 'João', cpf: '123.456.789-00');
      final json = cliente.toJson();
      final restaurado = Cliente.fromJson(json);
      
      expect(restaurado.nome, equals('João'));
      expect(restaurado.id, equals(1));
    });
    
    test('validação de CPF', () {
      expect(() {
        Cliente(id: null, nome: 'João', cpf: 'invalido');
      }, throwsA(isA<FormatException>()));
    });
  });
}
```

### 5.2 Testes de Database (SQLite)
Para `test/cliente_sql_manager_test.dart`:

```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/data/database/database_helper.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  tearDown(() {
    DatabaseHelper.resetInstance();
  });

  test('inserir e recuperar cliente', () async {
    final manager = ClienteSqlManager();
    final cliente = Cliente(id: null, nome: 'Maria', cpf: '987.654.321-00');
    
    final id = await manager.inserir(cliente);
    expect(id, greaterThan(0));
    
    final recuperado = await manager.buscarPorId(id);
    expect(recuperado?.nome, equals('Maria'));
  });
}
```

## 6. Code Review Checklist para Agentes

Antes de submeter qualquer implementação, verificar:

- [ ] Modelo tem `@JsonSerializable` e `.g.dart` foi gerado
- [ ] BLoC usa `@freezed` para eventos e estados
- [ ] Todos os métodos públicos têm documentação em português
- [ ] Usa `OperationResult` para tratamento de erros (não `try/catch` ou `Result`)
- [ ] Nomes de arquivo seguro (sem caracteres especiais)
- [ ] Concorrência tratada (locks se JSON, transações se SQLite)
- [ ] Testes unitários escritos e passando
- [ ] Build runner executado: `dart run build_runner build --delete-conflicting-outputs`
- [ ] Sem erros de lint: `flutter analyze`
- [ ] Segue padrões de Material 3
- [ ] Importações ordenadas: `dart:` → `package:` → relativos

## 7. Exemplo Completo: Implementar "Cadastro de Usuário Avançado"

### 7.1 Model - `lib/core/models/usuario_avancado.dart`
```dart
import 'package:json_annotation/json_annotation.dart';

part 'usuario_avancado.g.dart';

/// Usuário com permissões e informações avançadas.
@JsonSerializable()
class UsuarioAvancado {
  final int? id;
  final String nome;
  final String email;
  final List<String> permissoes; // ex: ['criar_cliente', 'editar_produto']
  
  const UsuarioAvancado({
    this.id,
    required this.nome,
    required this.email,
    required this.permissoes,
  });

  factory UsuarioAvancado.fromJson(Map<String, dynamic> json) =>
      _$UsuarioAvancadoFromJson(json);
  
  Map<String, dynamic> toJson() => _$UsuarioAvancadoToJson(this);
}
```

### 7.2 Manager - `lib/core/managers/usuario_avancado_manager.dart`
```dart
import 'package:system_loja/core/models/usuario_avancado.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Gerencia usuários avançados com permissões.
class UsuarioAvancadoManager {
  Future<OperationResult<UsuarioAvancado, String>> salvar(
    UsuarioAvancado usuario,
  ) async {
    try {
      // Validar email único
      // Serializar e salvar
      // Retornar usuário com ID atualizado
      return OperationSuccess(value: usuario);
    } catch (e) {
      return OperationFailure(error: 'Erro ao salvar usuário: $e');
    }
  }
}
```

### 7.3 BLoC - `lib/screens/usuario_avancado/bloc/usuario_avancado_bloc.dart`
### 7.4 Screen - `lib/screens/usuario_avancado/usuario_avancado_screen.dart`
### 7.5 Testes - `test/usuario_avancado_manager_test.dart`

## 8. Troubleshooting Comum

| Problema | Solução |
|----------|---------|
| `.g.dart` não gerado | Executar `dart run build_runner build --delete-conflicting-outputs` |
| `UnimplementedError` em BLoC | Implementar handlers `on<Evento>()` no construtor |
| Erro de `type mismatch` em `OperationResult` | Verificar tipos genéricos: `<T, E>` |
| Arquivo não salvo em Windows | Usar `toSafeFileName()` para remover caracteres inválidos |
| Conflito de lock em JSON | Aumentar timeout ou usar SQLite para operações frequentes |
| Tema não aplicado | Usar `Theme.of(context).colorScheme` em vez de cores hardcoded |

## 9. Recursos Rápidos

- **Effective Dart**: https://dart.dev/guides/language/effective-dart
- **Flutter BLoC**: https://bloclibrary.dev/
- **Freezed**: https://pub.dev/packages/freezed
- **Projeto (instruções)**: `.github/copilot-instructions.md`
- **Dart code style**: `.github/instructions/dartcode.instructions.md`

---

**Versão**: 1.0  
**Última atualização**: 9 de dezembro de 2025  
**Mantido por**: Sistema de Instruções do Projeto
