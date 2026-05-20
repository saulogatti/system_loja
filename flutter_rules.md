# Regras de Desenvolvimento Flutter (Específicas do Projeto)

Estas são as diretrizes consolidadas e estritas para o desenvolvimento em Flutter e Dart neste repositório. O objetivo é manter a consistência, arquitetura limpa e performance do aplicativo.
Caso precise de informações gerais sobre desenvolvimento em Flutter e Dart, consulte o arquivo 
[`.github\instructions\dart-n-flutter.instructions.md`](.github\instructions\dart-n-flutter.instructions.md).

## 1. Arquitetura e Organização (Clean Architecture)
* **Padrão de Camadas:** Siga rigidamente a separação entre `Presentation` (UI, Bloc/Cubit), `Domain` (Regras de negócio, Entidades) e `Data` (Repositórios, DTOs, DAOs, Fontes de Dados).
* **Isolamento da Camada Data:** A camada `data/` **nunca** deve importar classes das camadas `domain/` ou `application/`. Compartilhamentos e contratos devem viver em `core/`.
* **Tratamento de Erros e Banco de Dados:**
    * Os repositórios devem tratar suas exceções internamente com `try/catch` e sempre retornar o encapsulador `ResultStatus.error(...)`. Nenhuma exceção do repositório deve ser repassada (thrown) para a camada Presentation.
    * A camada Presentation (BLoC) **não** deve encapsular chamadas de repositório em `try/catch`. Ela deve fazer pattern-matching (verificação de status) do `ResultStatus` fornecido.
    * Injeção de suporte a cache (`CacheManager`) deve ser via `GetIt` ou construtor (nunca via Singletons hardcoded com `.instance`).

## 2. Gerenciamento de Estado (Presentation)
* **Padrão Absoluto:** Use **sempre BLoC / Cubit** (`flutter_bloc`) para o gerenciamento de estados da UI.
* **Repositórios para BLoC:** O BLoC consome métodos do repositório e converte as intenções do usuário (Eventos) nos estados adequados analisando o `ResultStatus` imutável, mantendo total autonomia para regras de exibição sem se meter nas fontes de dados.

## 3. Navegação e Roteamento
* **Padrão Absoluto:** Use **sempre o `auto_route`** para gerenciamento de páginas/telas do projeto.
* O componente clássico `Navigator` é proibido para transições comuns e é restrito a gerenciar modais temporários ou telas de interação ultrarrápidas sem permalink (como dialogs e BottomSheets). Toda alteração de rotas implicará na execução do gerador de códigos (build runner).

## 4. UI, Widgets e Layout
* **Tudo é Composição (Widgets Clássicos):** Prefira sempre a **composição** construindo pequenas classes `StatelessWidget` ao invés de grandes métodos que poluem uma mesma classe maior.
* **Imutabilidade Absoluta:** O uso da chave `const` é mandatário na inicialização dos widgets e declarações na chamada global para o gerenciamento correto da memória com a engine Flutter.
* **Performance Visceral:**
    * Invocações extensamente renderizáveis (grades e listas densas) utilizarão sempre formatações de listas com `.builder` (`ListView.builder`, `GridView.builder`).
    * Processamentos síncronos pesados e serializações que engasgam frame utilizarão fluxos `compute()` separadamente para offiliar a carga da thread-mãe nativa da UI.
* **Responsividade e Comportamento Modal Seguro:** Use recursos flexíveis `Expanded`/`Flexible` para redimensionamentos coesos no mesmo plano, com sobreposições usando `OverlayPortal` fora d'agua da arvore DOM local ao invés de misturar empilhamentos pesados nos modais fixos.

## 5. Design e Material 3 (M3)
* **Theming Centrado:** Configure a paleta de cores central com `ColorScheme.fromSeed` pelo `ThemeData`.
* **Aesthetics e Qualidade Premium:** Usufrua de hierarquias de fonte com leitura apurada, efeitos e `Layer Drop Shadows` ou "glow" de botões; emulando comportamentos `WidgetStateProperty` interativos perante cursores para Desktop e Web.
* **Tokens Customizados:** Ao exceder a paleta do Material native, faça uso obrigatório do `ThemeExtension`.
* **Rigor das Imagens Externas:** Qualquer carregamento de renderização `Image.network` sem os construtores de carregamento preventivo `loadingBuilder` e `errorBuilder` são inválidos.

## 6. Ferramentas, Comandos e Cultura local
* Rode a reestruturação por geração de código via terminal: `dart run build_runner build --delete-conflicting-outputs` a cada edição relavante no codegen (JSON, Drift, BLoC States, Rotas).
* Mantenha o formato global das descrições (comentários) da documentação em língua Portuguesa acompanhada pelo projeto.
