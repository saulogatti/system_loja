# Mockup da Tela de Configurações

## Layout Visual

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Configurações do Sistema                              ⟲ Restaurar│
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🔔 Notificações                                               │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Ativar notificações                         ◉ ON          │  │
│  │     Receber alertas do sistema                               │  │
│  │                                                               │  │
│  │  ⚫ Notificar vendas                            ◉ ON          │  │
│  │     Alertas sobre novas vendas                               │  │
│  │                                                               │  │
│  │  ⚫ Notificar estoque baixo                     ◉ ON          │  │
│  │     Alertas quando estoque está baixo                        │  │
│  │                                                               │  │
│  │  📊 Limite de estoque baixo                                  │  │
│  │     ├──────────●──────────────────────────────┤ 10 unidades  │  │
│  │     1                                       50                │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🎨 Aparência                                                  │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Tema escuro                                 ○ OFF         │  │
│  │     Ativar modo escuro                                       │  │
│  │                                                               │  │
│  │  🎨 Cor primária                                         ▣    │  │
│  │     Cor principal do aplicativo                    [Azul]    │  │
│  │                                                        →      │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 💾 Backup de Dados                                            │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Backup automático                           ○ OFF         │  │
│  │     Realizar backups periodicamente                          │  │
│  │                                                               │  │
│  │  💾 Realizar backup agora                               →    │  │
│  │     Criar cópia dos dados manualmente                        │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🧹 Limpeza de Dados                                           │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Limpeza automática de logs                  ○ OFF         │  │
│  │     Remover logs antigos automaticamente                     │  │
│  │                                                               │  │
│  │  🧹 Limpar logs antigos agora                           →    │  │
│  │     Remover logs com base na configuração                    │  │
│  │                                                               │  │
│  │  ⚠️  Limpar todos os dados                               →    │  │
│  │     Remover TODOS os dados do sistema           [VERMELHO]   │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🔒 Segurança                                                  │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ⚫ Exigir senha                                ○ OFF         │  │
│  │     Solicitar senha ao abrir o aplicativo                    │  │
│  │                                                               │  │
│  │  ⚫ Permitir múltiplos usuários                 ○ OFF         │  │
│  │     Habilitar gestão de usuários                             │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │ 🗄️  Banco de Dados                                            │  │
│  ├──────────────────────────────────────────────────────────────┤  │
│  │                                                               │  │
│  │  ◉ JSON (Arquivos locais)                                    │  │
│  │     Leve e simples, recomendado para uso básico              │  │
│  │                                                               │  │
│  │  ○ SQL (SQLite)                                               │  │
│  │     Mais robusto, recomendado para muitos dados              │  │
│  │                                                               │  │
│  │  ℹ️  Nota: Alterar o tipo de banco de dados requer           │  │
│  │     reinicialização do aplicativo.                           │  │
│  │                                                               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                    💾 SALVAR CONFIGURAÇÕES                    │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

## Interações por Seção

### 1. Header (AppBar)
- **Botão Voltar (←)**: Retorna à tela inicial
- **Título**: "Configurações do Sistema"
- **Botão Restaurar (⟲)**: Abre diálogo de confirmação para restaurar padrões

### 2. Notificações (Card Azul)
- **Toggle Mestre**: Controla todas as notificações
- **Toggle Vendas**: Ativa/desativa notificações de vendas
- **Toggle Estoque**: Ativa/desativa alertas de estoque baixo
- **Slider Limite**: Ajusta o limite (1-50 unidades) com preview do valor

### 3. Aparência (Card Verde)
- **Toggle Tema**: Liga/desliga modo escuro
- **Seletor de Cor**: Abre modal com 8 opções de cores
  - Mostra preview da cor atual
  - Cores: Azul, Verde, Laranja, Roxo, Vermelho, Rosa, Ciano, Índigo

### 4. Backup (Card Laranja)
- **Toggle Automático**: Habilita backups periódicos
- **Seletor Frequência**: Modal com opções (Diário/Semanal/Mensal)
  - Aparece apenas se backup automático estiver ativo
- **Botão Manual**: Executa backup imediato
  - Mostra progresso e resultado

### 5. Limpeza (Card Vermelho Claro)
- **Toggle Automático**: Habilita limpeza automática
- **Slider Dias**: Define retenção de logs (7-365 dias)
  - Aparece apenas se limpeza automática estiver ativa
- **Botão Limpar Logs**: Remove logs antigos
  - Requer confirmação
- **Botão Limpar Tudo**: Remove TODOS os dados
  - Botão vermelho destacado
  - Requer confirmação dupla com alerta severo

### 6. Segurança (Card Roxo)
- **Toggle Senha**: Habilita autenticação
- **Slider Bloqueio**: Define timeout (1-60 minutos)
  - Aparece apenas se senha estiver habilitada
- **Toggle Usuários**: Habilita sistema multi-usuário

### 7. Banco de Dados (Card Cinza)
- **Radio JSON**: Seleciona persistência em arquivos
  - Marcado por padrão
  - Descrição: "Leve e simples"
- **Radio SQL**: Seleciona persistência em SQLite
  - Descrição: "Mais robusto"
- **Nota Informativa**: Aviso sobre reinicialização

### 8. Botão Salvar (Footer)
- **Estilo**: Botão grande e destacado
- **Cor**: Azul primário com texto branco
- **Ícone**: Disco de salvamento
- **Feedback**: SnackBar verde (sucesso) ou vermelha (erro)

## Fluxos de Interação

### Salvar Configurações
```
1. Usuário altera valores
2. Clica em "SALVAR CONFIGURAÇÕES"
3. Indicador de carregamento aparece
4. Dados são persistidos no JSON
5. SnackBar confirma sucesso/erro
6. Estado é atualizado na memória
```

### Realizar Backup
```
1. Usuário clica em "Realizar backup agora"
2. Sistema cria pasta com timestamp
3. Copia arquivos JSON
4. SnackBar mostra resultado
   - Verde: "Backup realizado com sucesso!"
   - Vermelha: "Erro ao realizar backup"
```

### Limpar Todos os Dados
```
1. Usuário clica em "Limpar todos os dados"
2. Modal de confirmação aparece:
   ┌────────────────────────────────────┐
   │         ⚠️  ATENÇÃO!                │
   ├────────────────────────────────────┤
   │ Esta ação irá REMOVER TODOS OS     │
   │ DADOS do sistema (clientes,        │
   │ produtos, notas fiscais, usuários  │
   │ e logs).                           │
   │                                    │
   │ Esta ação NÃO PODE ser desfeita!   │
   │                                    │
   │ Tem certeza que deseja continuar?  │
   ├────────────────────────────────────┤
   │ [Cancelar]  [Sim, Limpar Tudo] 🔴  │
   └────────────────────────────────────┘
3. Se confirmado:
   - Todos os arquivos JSON são zerados
   - SnackBar laranja: "Todos os dados foram removidos!"
```

### Restaurar Padrão
```
1. Usuário clica no ícone ⟲ no AppBar
2. Modal de confirmação:
   ┌────────────────────────────────────┐
   │   Restaurar Configurações          │
   ├────────────────────────────────────┤
   │ Deseja restaurar todas as          │
   │ configurações para os valores      │
   │ padrão?                            │
   ├────────────────────────────────────┤
   │    [Cancelar]    [Restaurar]       │
   └────────────────────────────────────┘
3. Se confirmado:
   - Valores voltam ao padrão
   - UI é atualizada
   - SnackBar verde: "Configurações restauradas!"
```

### Seletor de Cor
```
1. Usuário clica em "Cor primária"
2. Modal aparece com opções:
   ┌────────────────────────────────────┐
   │       Escolher Cor                 │
   ├────────────────────────────────────┤
   │  ▣ Azul                            │
   │  ▣ Verde                           │
   │  ▣ Laranja                         │
   │  ▣ Roxo                            │
   │  ▣ Vermelho                        │
   │  ▣ Rosa                            │
   │  ▣ Ciano                           │
   │  ▣ Índigo                          │
   └────────────────────────────────────┘
3. Usuário seleciona cor
4. Modal fecha
5. Preview atualiza instantaneamente
```

## Estados Condicionais

### Notificações Desabilitadas
- Sub-opções ficam acinzentadas
- Slider de limite fica oculto
- Toggle de vendas/estoque não é clicável

### Backup Automático Desabilitado
- Seletor de frequência fica oculto

### Limpeza Automática Desabilitada
- Slider de dias fica oculto

### Senha Desabilitada
- Slider de tempo de bloqueio fica oculto

## Responsividade

### Desktop (> 800px)
- Cards ocupam largura máxima de 600px centralizados
- Padding lateral generoso

### Tablet (400-800px)
- Cards ocupam 90% da largura
- Padding moderado

### Mobile (< 400px)
- Cards ocupam 100% da largura
- ScrollView habilitado
- Padding mínimo para maximizar espaço

## Acessibilidade

- ✅ Labels descritivos em todos os controles
- ✅ Subtítulos explicativos
- ✅ Ícones informativos
- ✅ Cores com contraste adequado
- ✅ Feedbacks visuais claros
- ✅ Confirmações para ações destrutivas
- ✅ Tooltips nos botões do AppBar

## Performance

- ⚡ Renderização otimizada com setState local
- ⚡ Operações de I/O em background
- ⚡ Indicadores de carregamento durante operações assíncronas
- ⚡ Validações instantâneas
- ⚡ UI responsiva e fluida

## Compatibilidade

- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ iOS
- ✅ Android
- ✅ Web
