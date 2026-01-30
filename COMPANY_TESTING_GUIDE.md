# Guia de Testes - Feature Cadastro de Empresas

## Como Testar

### Pré-requisitos
1. Executar a aplicação: `flutter run -d <device>`
2. Navegar até a tela "Cadastro de Empresa" via:
   - Card "Cadastro de Empresa" na Home Screen, OU
   - Bottom Navigation bar (ícone "Business")

---

## Casos de Teste

### ✅ CT-01: Cadastro de Empresa Completo
**Objetivo**: Validar cadastro com todos os campos preenchidos

**Passos**:
1. Preencher "Razão Social": `Empresa Teste LTDA`
2. Preencher "CNPJ": `12345678000195` (14 dígitos)
3. Preencher "Email": `contato@empresateste.com`
4. Preencher "Rua": `Av. Paulista, 1000`
5. Preencher "CEP": `01310-100`
6. Preencher "Bairro": `Bela Vista`
7. Preencher "Cidade": `São Paulo`
8. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ✅ SnackBar verde: "Empresa cadastrada com sucesso!"
- ✅ Formulário limpo
- ✅ Empresa aparece na lista com todos os dados
- ✅ Card da empresa exibe: nome, CNPJ, email e cidade

---

### ✅ CT-02: Cadastro com Campos Opcionais Vazios
**Objetivo**: Validar cadastro com apenas campos obrigatórios

**Passos**:
1. Preencher "Razão Social": `Empresa Mínima`
2. Preencher "CNPJ": `98765432000188`
3. Deixar demais campos vazios
4. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ✅ Empresa cadastrada com sucesso
- ✅ Card exibe "Sem email" quando email não preenchido
- ✅ Detalhes mostram apenas campos preenchidos

---

### ❌ CT-03: CNPJ Duplicado
**Objetivo**: Validar constraint UNIQUE do CNPJ

**Passos**:
1. Cadastrar primeira empresa com CNPJ `11122233000144`
2. Tentar cadastrar segunda empresa com MESMO CNPJ `11122233000144`
3. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ SnackBar vermelho: "Já existe uma empresa cadastrada com o CNPJ 11122233000144."
- ❌ Empresa NÃO é cadastrada
- ❌ Formulário mantém os dados

---

### ❌ CT-04: Validação de CNPJ Inválido
**Objetivo**: Validar tamanho do CNPJ

**Passos - Menos de 14 dígitos**:
1. Preencher "CNPJ": `123456789` (9 dígitos)
2. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ Mensagem de erro: "CNPJ deve conter 14 dígitos"

**Passos - Mais de 14 dígitos**:
1. Preencher "CNPJ": `123456789012345` (15 dígitos)
2. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ Mensagem de erro: "CNPJ deve conter 14 dígitos"

**Passos - Campo vazio**:
1. Deixar "CNPJ" vazio
2. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ Mensagem de erro: "CNPJ é obrigatório"

---

### ❌ CT-05: Validação de Razão Social
**Objetivo**: Validar campos obrigatórios

**Passos - Campo vazio**:
1. Deixar "Razão Social" vazio
2. Preencher CNPJ válido
3. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ Mensagem de erro: "Razão Social é obrigatório"

**Passos - Nome muito curto**:
1. Preencher "Razão Social": `AB` (2 caracteres)
2. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ Mensagem de erro: "Razão Social deve ter no mínimo 3 caracteres"

---

### ❌ CT-06: Validação de Email
**Objetivo**: Validar formato de email

**Passos**:
1. Preencher dados válidos
2. Preencher "Email": `emailinvalido` (sem @)
3. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ❌ SnackBar vermelho: "Erro: Email inválido!"

---

### ✅ CT-07: Busca por CNPJ Existente
**Objetivo**: Validar busca de empresa

**Passos**:
1. Cadastrar empresa com CNPJ `55566677000100`
2. No campo "Buscar Empresa por CNPJ", digitar: `55566677000100`
3. Clicar em "Buscar"

**Resultado Esperado**:
- ✅ Dialog aparece com título da razão social
- ✅ Dialog exibe todos os dados da empresa:
  - CNPJ
  - Email (se preenchido)
  - Rua (se preenchido)
  - CEP (se preenchido)
  - Bairro (se preenchido)
  - Cidade (se preenchido)

---

### ❌ CT-08: Busca por CNPJ Inexistente
**Objetivo**: Validar tratamento de empresa não encontrada

**Passos**:
1. No campo de busca, digitar CNPJ que não existe: `99999999000199`
2. Clicar em "Buscar"

**Resultado Esperado**:
- ❌ SnackBar vermelho: "Empresa com CNPJ 99999999000199 não encontrada."

---

### ❌ CT-09: Busca com Campo Vazio
**Objetivo**: Validar busca com campo vazio

**Passos**:
1. Deixar campo de busca vazio
2. Clicar em "Buscar"

**Resultado Esperado**:
- ❌ SnackBar laranja: "Digite um CNPJ para buscar"

---

### 🗑️ CT-10: Exclusão de Empresa
**Objetivo**: Validar deleção com confirmação

**Passos**:
1. Cadastrar empresa teste
2. Na lista, clicar no ícone de lixeira do card
3. Na dialog de confirmação, clicar "Cancelar"

**Resultado Esperado**:
- ✅ Dialog fecha
- ✅ Empresa NÃO é deletada

**Passos (continuação)**:
4. Clicar novamente no ícone de lixeira
5. Na dialog, clicar "Deletar"

**Resultado Esperado**:
- ✅ Dialog fecha
- ✅ SnackBar verde: "Empresa deletada com sucesso!"
- ✅ Empresa REMOVIDA da lista
- ✅ Card desaparece

---

### 👆 CT-11: Visualizar Detalhes pelo Card
**Objetivo**: Validar clique no card da lista

**Passos**:
1. Cadastrar empresa com dados completos
2. Na lista, clicar no card da empresa (não no ícone de lixeira)

**Resultado Esperado**:
- ✅ Dialog de detalhes aparece (mesmo comportamento da busca)
- ✅ Exibe todos os campos preenchidos
- ✅ Botão "Fechar" fecha o dialog

---

### 📋 CT-12: Lista Vazia
**Objetivo**: Validar estado inicial

**Passos**:
1. Acessar tela sem empresas cadastradas

**Resultado Esperado**:
- ✅ Mensagem exibida: "Nenhuma empresa cadastrada"
- ✅ Cor cinza, centralizada

---

### 🔄 CT-13: Formatação Automática de CNPJ
**Objetivo**: Validar remoção de caracteres especiais

**Passos**:
1. Preencher "CNPJ": `12.345.678/0001-95` (com formatação)
2. Preencher demais campos
3. Clicar em "Adicionar Empresa"

**Resultado Esperado**:
- ✅ Empresa cadastrada com CNPJ armazenado como: `12345678000195` (sem formatação)
- ✅ Na busca, pode usar com ou sem formatação

---

## Testes de Integração

### 🔗 CT-14: Navegação
**Passos**:
1. Na Home Screen, clicar no card "Cadastro de Empresa"
2. Verificar se abre a tela correta
3. Usar Bottom Navigation para ir a outra tela
4. Voltar usando Bottom Navigation (ícone Business)

**Resultado Esperado**:
- ✅ Navegação fluida
- ✅ Estado preservado (lista não recarrega desnecessariamente)

---

### 💾 CT-15: Persistência de Dados
**Passos**:
1. Cadastrar 3 empresas
2. Fechar aplicação completamente
3. Reabrir aplicação
4. Navegar até tela de empresas

**Resultado Esperado**:
- ✅ Todas as 3 empresas aparecem na lista
- ✅ Dados completos preservados

---

## Checklist de Validação Final

- [ ] Formulário funciona corretamente
- [ ] Validações impedem cadastros inválidos
- [ ] CNPJ único é respeitado
- [ ] Busca retorna resultados corretos
- [ ] Exclusão funciona com confirmação
- [ ] Lista exibe empresas cadastradas
- [ ] Dialog de detalhes mostra informações completas
- [ ] Navegação funciona (Home e Bottom Nav)
- [ ] SnackBars aparecem com feedback adequado
- [ ] Dados persistem após reiniciar app
- [ ] Não há crashes ou erros no console
- [ ] Interface responsiva (diferentes tamanhos de tela)

---

## Relatório de Bugs

Se encontrar problemas, reportar com:
1. **Passos para reproduzir**
2. **Comportamento esperado**
3. **Comportamento atual**
4. **Screenshots (se aplicável)**
5. **Logs do console**

---

**Versão do Schema**: 9
**Última atualização**: 30/01/2026
