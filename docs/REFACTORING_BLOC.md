# Refatoração para BLoC Pattern - Tela de Configurações

## Visão Geral

A tela de configurações foi refatorada para seguir o padrão BLoC (Business Logic Component), conforme solicitado nos comentários do PR. Esta refatoração melhora a separação de responsabilidades, facilita testes e torna o código mais manutenível.

## Mudanças Realizadas

### 1. Implementação do BLoC Pattern

#### Estrutura Criada

```
lib/screens/configuracoes/bloc/
├── configuracoes_bloc.dart   - Lógica de negócio
├── configuracoes_event.dart  - 6 eventos
└── configuracoes_state.dart  - 5 estados
```

#### Eventos Implementados

1. `CarregarConfiguracoesEvent` - Carrega configurações iniciais
2. `AtualizarConfiguracoesEvent` - Salva configurações
3. `RestaurarPadraoEvent` - Restaura valores padrão
4. `RealizarBackupEvent` - Executa backup
5. `LimparLogsAntigosEvent` - Remove logs antigos
6. `LimparTodosDadosEvent` - Limpa todos os dados

#### Estados Implementados

1. `ConfiguracoesInitial` - Estado inicial
2. `ConfiguracoesLoading` - Carregando
3. `ConfiguracoesLoaded` - Carregado com sucesso
4. `ConfiguracoesSuccess` - Operação bem-sucedida
5. `ConfiguracoesError` - Erro na operação

### 2. Modularização da UI

#### Antes
- 1 arquivo: `configuracoes_screen.dart` (739 linhas)

#### Depois
- 1 arquivo principal: `configuracoes_screen.dart` (~350 linhas)
- 6 widgets modulares:
  - `secao_notificacoes.dart` (~100 linhas)
  - `secao_tema.dart` (~80 linhas)
  - `secao_backup.dart` (~85 linhas)
  - `secao_limpeza.dart` (~100 linhas)
  - `secao_seguranca.dart` (~85 linhas)
  - `secao_banco_dados.dart` (~90 linhas)

#### Benefícios
- ✅ Código mais legível e organizado
- ✅ Widgets reutilizáveis
- ✅ Mais fácil de manter e testar
- ✅ Melhor performance (widgets menores)

### 3. Documentação Melhorada

Todos os 15 atributos do modelo `Configuracao` agora têm documentação completa:

```dart
/// Controla se as notificações estão ativadas globalmente no sistema
final bool notificacoesAtivadas;

/// Quantidade mínima de unidades em estoque para disparar alerta (1-50)
final int limiteEstoqueBaixo;

/// Frequência do backup automático: 'diario', 'semanal' ou 'mensal'
final String frequenciaBackup;
```

## Separação de Responsabilidades

### Antes (Padrão Manager)
```
ConfiguracoesScreen → ConfiguracaoManager → JSON
```

### Depois (Padrão BLoC)
```
ConfiguracoesScreen → ConfiguracoesBloc → ConfiguracaoManager → JSON
```

### Vantagens
- UI não conhece detalhes de persistência
- Manager pode ser mockado nos testes do BLoC
- BLoC pode ser testado independentemente da UI
- Estado é previsível e rastreável

## Dependências Adicionadas

### pubspec.yaml
```yaml
dependencies:
  flutter_bloc: ^8.1.6  # State management
  equatable: ^2.0.5     # Comparação de eventos/estados
```

## Uso na UI

### Antes (StatefulWidget com Manager)
```dart
class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final ConfiguracaoManager _manager = ConfiguracaoManager();
  late Configuracao _config;
  
  void _salvar() async {
    await _manager.atualizarConfiguracao(_config);
    // Lógica de UI misturada
  }
}
```

### Depois (BLoC)
```dart
class ConfiguracoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfiguracoesBloc()..add(CarregarConfiguracoesEvent()),
      child: BlocConsumer<ConfiguracoesBloc, ConfiguracoesState>(
        listener: (context, state) {
          if (state is ConfiguracoesSuccess) {
            // Mostra sucesso
          }
        },
        builder: (context, state) {
          if (state is ConfiguracoesLoaded) {
            return _buildContent(state.configuracao);
          }
          // Outros estados...
        },
      ),
    );
  }
}
```

## Testes

### Facilidade de Teste

**BLoC pode ser testado isoladamente:**
```dart
test('deve emitir ConfiguracoesSuccess ao atualizar', () async {
  final mockManager = MockConfiguracaoManager();
  final bloc = ConfiguracoesBloc(manager: mockManager);
  
  bloc.add(AtualizarConfiguracoesEvent(config));
  
  await expectLater(
    bloc.stream,
    emitsInOrder([
      ConfiguracoesLoading(),
      ConfiguracoesSuccess(config, 'Sucesso'),
      ConfiguracoesLoaded(config),
    ]),
  );
});
```

## Estrutura de Diretórios Final

```
lib/screens/configuracoes/
├── configuracoes_screen.dart    # Tela principal
├── bloc/                         # Lógica de negócio
│   ├── configuracoes_bloc.dart
│   ├── configuracoes_event.dart
│   └── configuracoes_state.dart
└── widgets/                      # Componentes UI
    ├── secao_notificacoes.dart
    ├── secao_tema.dart
    ├── secao_backup.dart
    ├── secao_limpeza.dart
    ├── secao_seguranca.dart
    └── secao_banco_dados.dart
```

## Próximos Passos

1. ✅ Migrar outras telas para BLoC pattern
2. ✅ Criar testes unitários para ConfiguracoesBloc
3. ✅ Adicionar testes de widget para os componentes
4. ✅ Documentar padrão BLoC no README

## Referências

- [flutter_bloc Documentation](https://bloclibrary.dev/)
- [Effective BLoC Pattern](https://verygood.ventures/blog/effective-bloc-pattern)
- [BLoC Architecture Tutorial](https://bloclibrary.dev/#/architecture)

---

**Commit:** 4451857  
**Data:** Dezembro 2024  
**Autor:** @copilot
