
# Análise Arquitetural e Plano de Migração para Clean Architecture

**Diagnóstico atual**

A base já tem uma boa estrutura por camadas, mas ainda está em um modelo híbrido entre arquitetura em camadas tradicional e Clean Architecture.

1. Apresentação está bem definida em screens, com BLoC/Cubit e UI Flutter.
2. Existem contratos de repositório em interface, o que é um ponto forte para inversão de dependência.
3. Implementações concretas de repositório estão em repository, mas essa pasta está dentro de core, o que mistura regra de negócio com infraestrutura.
4. Infra de persistência está organizada em Drift/DAO em database.
5. DI centralizada em app_injection.dart, porém a apresentação ainda resolve dependências direto via service locator em main.dart.

**Principais desalinhamentos com Clean Architecture**

1. Core depende de Flutter:
app_theme.dart,
app_theme_settings.dart,
system_error_manager.dart.

2. Core depende de Drift em modelos de domínio:
address.dart,
price_configuration.dart.

3. Core depende de data layer:
system_error.dart,
system_configuration.dart,
code_generator_service.dart.

4. Camada de apresentação importando concreto de repositório:
product_cubit.dart.

5. Código legado em managers com papel de repositório/infra:
configuration_repository.dart.

6. Violação da convenção do próprio projeto sobre não propagar exceção entre camadas:
configuration_repository.dart.

**Lista do que precisa ser alterado para ficar em Clean Architecture**

Ordem sugerida por prioridade e impacto.

1. Separar camadas de forma explícita:
criar estrutura alvo Domain, Application, Infrastructure, Presentation e migrar classes para cada camada.

2. Tornar core puro:
remover qualquer import de Flutter e Drift da camada core.
3. Mover Theme e Settings para fora do core:
deixar abstrações no domínio/aplicação e implementação Flutter na apresentação ou infraestrutura.
4. Mover conversores Drift dos modelos:
tirar JsonTypeConverter dos modelos em core e levar para mappers/converters em infraestrutura.
5. Eliminar dependências core -> data:
core não deve importar nada de data.
6. Refatorar CodeGeneratorService por portas:
substituir dependência de DAO por interfaces de aplicação/domínio.
7. Corrigir ProductCubit:
remover import concreto e usar só contrato.
8. Tratar managers legados:
migrar configuration_repository.dart para camada adequada ou quebrar em use cases e adapters.
9. Introduzir Use Cases:
BLoCs/Cubits devem depender de casos de uso, não de repositórios diretamente.
10. Padronizar tratamento de erro por ResultStatus:
evitar rethrow na fronteira de aplicação e devolver erros tipados.
11. Reduzir acoplamento do service locator na UI:
manter GetIt no composition root e preferir injeção por construtor dos widgets/blocs.
12. Criar testes de arquitetura:
regras automáticas para bloquear imports proibidos, por exemplo core não pode importar flutter, drift ou data.

**Plano de execução prático**
1. Sprint 1: itens 2, 3, 4, 7.
2. Sprint 2: itens 5, 6, 8.
3. Sprint 3: itens 9, 10, 11, 12.

Isso te leva para uma Clean Architecture real, sem quebrar tudo de uma vez e com risco controlado. Primeiro ganho de alto impacto é limpar dependências indevidas da camada core.Análise arquitetural concluída com verificação direta dos arquivos, identificação dos desalinhamentos com Clean Architecture e entrega da lista priorizada de mudanças necessárias (incluindo dependências indevidas entre camadas, pontos de alto impacto e sequência de migração). Também registrei em memória de repositório a versão de schema Drift validada no branch atual para evitar decisões futuras com dado divergente.Resumo breve: finalizei a análise da arquitetura atual, validei os achados com evidências no código, listei as alterações necessárias para aderir à Clean Architecture e priorizei por impacto/esforço. Agora vou marcar formalmente a tarefa como concluída.

