# Flutter Feature Template

Use este template para criar uma feature nova ou reorganizar uma estrutura mista.

## Estrutura sugerida

```text
feature_name/
  presentation/
    bloc/
      feature_bloc.dart
      feature_event.dart
      feature_state.dart
    pages/
      feature_page.dart
    widgets/
      feature_view.dart
      feature_header.dart
      feature_list.dart
      feature_list_item.dart
  domain/
    entities/
      feature_entity.dart
    repositories/
      feature_repository.dart
    usecases/
      get_feature.dart
  data/
    datasources/
      feature_remote_datasource.dart
    models/
      feature_model.dart
    repositories/
      feature_repository_impl.dart
```

## Notas

- feature_page.dart monta o bloco e a composicao principal.
- feature_view.dart orquestra layout com widgets menores.
- Item de lista, secoes de formulario e widgets de estado devem ser separados quando melhorarem leitura.
- O bloco chama casos de uso e emite estados de UI explicitos.
- Interface de repositorio fica no dominio; implementacao no data.

## Modelo de estado sugerido

- initial
- loading
- success com dados
- empty
- error com mensagem

## Regras de split

Separe widget em novo arquivo quando:

- O build ficar cansativo para leitura.
- O widget misturar layout, renderizacao de itens e efeitos colaterais.
- Uma secao tiver nome de dominio claro, como FilterBar ou OrderSummary.
- O mesmo padrao visual aparecer em mais de um lugar com pequenas variacoes.

## Evitar

- Regra de negocio em widget.
- Chamada de repositorio diretamente da UI.
- Arquivo unico com page, bloc, state, event e muitos widgets auxiliares sem necessidade.
- Abstracao reutilizavel criada antes da segunda necessidade real.
