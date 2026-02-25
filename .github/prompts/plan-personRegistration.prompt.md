## Plan: Tela unificada de cadastro de pessoa (DRAFT)

Vamos criar uma tela nova e separada, focada apenas em UI + tratamento de entrada, para selecionar tipo de pessoa (física/jurídica) e alternar dinamicamente o campo de documento entre CPF e CNPJ. O plano reutiliza padrões já existentes de formulário e validação do projeto para reduzir risco e manter consistência visual/arquitetural. Nesta etapa, não haverá integração com BLoC/repositório, nem fluxos de salvar, buscar, listar ou consulta. Também vamos manter o comportamento definido: saída do documento em dígitos, validação de CNPJ por formato/tamanho, e limpeza do campo ao trocar o tipo.

**Steps**
1. Definir contrato de dados da nova tela com estado local: tipo de pessoa selecionado, controllers e callback de submissão sem persistência; basear no padrão de formulário usado em [lib/screens/customer/widgets/customer_form.dart](lib/screens/customer/widgets/customer_form.dart) e [lib/screens/company/widgets/company_form.dart](lib/screens/company/widgets/company_form.dart).
2. Criar enum/modelo leve para tipo de pessoa (`personType`: `individual`/`company`) em área de screen/model para evitar acoplamento com domínio atual; manter nomenclatura em inglês e documentação `///` em português.
3. Implementar novo widget de tela separado em pasta própria (ex.: [lib/screens/person_registration/](lib/screens/person_registration/)), com seletor explícito do tipo e formulário comum de dados compartilhados (nome/razão, email, endereço etc.) + campo dinâmico de documento.
4. Reutilizar formatadores existentes de CPF/CNPJ em [lib/core/utils/text_formatters.dart](lib/core/utils/text_formatters.dart) e limpeza por regex em [lib/screens/utils/constants.dart](lib/screens/utils/constants.dart), garantindo que o callback exponha documento sem máscara.
5. Aplicar validação condicional no campo documento: CPF com validador atual (incluindo regra existente) e CNPJ com obrigatoriedade + 14 dígitos; montar composição com utilitário de validação em [lib/core/utils/validators.dart](lib/core/utils/validators.dart).
6. Implementar regra de troca de tipo: ao alternar física/jurídica, limpar o controller de documento, atualizar máscara/label/hint e resetar erro do campo para evitar estado inválido residual.
7. (Opcional de navegação mínima) Registrar rota nova no roteador para acesso isolado, sem alterar comportamento das telas atuais, seguindo padrão em [lib/screens/route/route_app.dart](lib/screens/route/route_app.dart) e geração em [lib/screens/route/route_app.gr.dart](lib/screens/route/route_app.gr.dart).
8. Adicionar testes de widget/validação focados na nova tela: alternância de tipo, troca de máscara, limpeza ao trocar tipo, validação de CPF/CNPJ e payload de saída em dígitos.

**Verification**
- Rodar geração de código se houver alteração de rotas/anotações: `dart run build_runner build --delete-conflicting-outputs`.
- Rodar análise estática: `flutter analyze`.
- Rodar testes direcionados da nova tela (e suite relacionada de validação): `flutter test`.
- Validar manualmente: abrir tela, alternar tipo, confirmar limpeza do documento e mensagens de erro corretas no submit.

**Decisions**
- Saída do documento no callback: somente dígitos.
- Validação de CNPJ nesta etapa: apenas formato/tamanho (14 dígitos).
- Ao trocar tipo de pessoa: limpar campo de documento imediatamente.
