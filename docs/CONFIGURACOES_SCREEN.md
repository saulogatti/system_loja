# Tela de Configurações do Sistema

## Visão Geral

A tela de configurações (`ConfiguracoesScreen`) permite aos administradores ajustar as preferências gerais do sistema, incluindo notificações, aparência, backup, limpeza de dados, segurança e tipo de banco de dados.

## Estrutura da Interface

### AppBar
- **Título**: "Configurações do Sistema"
- **Ação**: Botão de restaurar configurações padrão (ícone de restauração)

### Corpo (Scrollable)

#### 1. Seção de Notificações 🔔
Permite configurar alertas do sistema:

- **Ativar notificações** (Switch)
  - Habilita/desabilita todas as notificações
  
- **Notificar vendas** (Switch)
  - Alertas sobre novas vendas realizadas
  - Desabilitado se notificações estiverem desativadas
  
- **Notificar estoque baixo** (Switch)
  - Alertas quando produtos atingem limite mínimo
  - Desabilitado se notificações estiverem desativadas
  
- **Limite de estoque baixo** (Slider: 1-50)
  - Define o número de unidades para disparar alerta
  - Visível apenas se "Notificar estoque baixo" estiver ativo

#### 2. Seção de Aparência 🎨
Personalização visual do aplicativo:

- **Tema escuro** (Switch)
  - Alterna entre modo claro e escuro
  
- **Cor primária** (Seletor)
  - Escolhe a cor principal do aplicativo
  - Opções disponíveis:
    - Azul (#2196F3) - Padrão
    - Verde (#4CAF50)
    - Laranja (#FF9800)
    - Roxo (#9C27B0)
    - Vermelho (#F44336)
    - Rosa (#E91E63)
    - Ciano (#00BCD4)
    - Índigo (#3F51B5)

#### 3. Seção de Backup 💾
Gerenciamento de cópias de segurança:

- **Backup automático** (Switch)
  - Habilita backups periódicos
  
- **Frequência de backup** (Seletor)
  - Opções: Diário, Semanal, Mensal
  - Visível apenas se backup automático estiver ativo
  
- **Realizar backup agora** (Botão)
  - Cria cópia manual dos dados imediatamente
  - Arquivos salvos em: `data/backups/[timestamp]/`
  - Inclui: clientes, produtos, notas fiscais, usuários, logs e configurações

#### 4. Seção de Limpeza de Dados 🧹
Manutenção e remoção de dados:

- **Limpeza automática de logs** (Switch)
  - Remove logs antigos automaticamente
  
- **Dias para manter logs** (Slider: 7-365)
  - Define por quanto tempo manter registros
  - Visível apenas se limpeza automática estiver ativa
  
- **Limpar logs antigos agora** (Botão)
  - Remove logs com base na configuração atual
  - Requer confirmação
  
- **Limpar todos os dados** (Botão - Vermelho)
  - ⚠️ AÇÃO IRREVERSÍVEL
  - Remove TODOS os dados do sistema
  - Requer confirmação dupla com alerta

#### 5. Seção de Segurança 🔒
Opções de proteção e acesso:

- **Exigir senha** (Switch)
  - Solicita autenticação ao abrir o aplicativo
  
- **Tempo de bloqueio** (Slider: 1-60 minutos)
  - Tempo de inatividade antes de solicitar senha
  - Visível apenas se "Exigir senha" estiver ativo
  
- **Permitir múltiplos usuários** (Switch)
  - Habilita sistema de gestão de usuários

#### 6. Seção de Banco de Dados 🗄️
Escolha do sistema de persistência:

- **JSON (Arquivos locais)** (Radio)
  - Leve e simples
  - Recomendado para uso básico
  - Padrão do sistema
  
- **SQL (SQLite)** (Radio)
  - Mais robusto
  - Recomendado para grande volume de dados
  - Requer reinicialização do aplicativo

**Nota**: Alterar o tipo de banco de dados requer reinicialização do aplicativo.

### Botão de Salvar
- **Localização**: Parte inferior da tela
- **Função**: Persiste todas as alterações
- **Estilo**: Botão destacado com ícone de salvar
- **Feedback**: SnackBar verde em caso de sucesso, vermelha em caso de erro

## Funcionalidades Especiais

### Restaurar Padrão
- Acesso via ícone no AppBar
- Requer confirmação
- Restaura TODAS as configurações para valores iniciais

### Validações
- Todos os valores são validados antes de salvar
- Feedback visual para cada ação (SnackBars)
- Indicador de carregamento durante operações assíncronas

### Persistência
- Configurações salvas em: `data/configuracao.json`
- Carregamento automático ao abrir a tela
- Thread-safe usando locks de sincronização

## Arquivos Relacionados

### Modelo
- `lib/core/models/configuracao.dart` - Definição da estrutura de dados
- `lib/core/models/configuracao.g.dart` - Serialização JSON (gerado)

### Manager
- `lib/core/managers/configuracao_manager.dart` - Lógica de negócio

### UI
- `lib/screens/configuracoes_screen.dart` - Interface gráfica

### Testes
- `test/configuracao_manager_test.dart` - 13 testes unitários

## Navegação

Acesso pela tela inicial (`HomeScreen`):
- Card "Configurações do Sistema"
- Ícone: Settings (engrenagem)
- Cor: Teal

## Valores Padrão

```dart
Configuracao.padrao() {
  notificacoesAtivadas: true,
  notificarVendas: true,
  notificarEstoqueBaixo: true,
  limiteEstoqueBaixo: 10,
  temaEscuro: false,
  corPrimaria: '#2196F3', // Azul
  backupAutomatico: false,
  frequenciaBackup: 'semanal',
  localBackup: 'data/backups',
  limpezaAutomatica: false,
  diasManterLogs: 90,
  exigirSenha: false,
  tempoBloqueioMinutos: 15,
  permitirMultiplosUsuarios: false,
  tipoBancoDados: 'json',
}
```

## Operações Assíncronas

Todas as operações que modificam dados são assíncronas e mostram indicador de carregamento:
- Salvar configurações
- Restaurar padrão
- Realizar backup
- Limpar logs
- Limpar todos os dados

## Tratamento de Erros

Todas as operações possuem tratamento de erros com:
- Try-catch blocks
- Logging de erros
- Feedback visual ao usuário (SnackBar vermelho)
- Mensagens descritivas

## Considerações de UX

1. **Hierarquia Visual**: Cards separados por funcionalidade
2. **Feedback Imediato**: Switches e sliders atualizam estado instantaneamente
3. **Confirmações**: Ações destrutivas requerem confirmação explícita
4. **Acessibilidade**: Labels descritivos em todos os controles
5. **Responsividade**: SingleChildScrollView para suporte a telas pequenas
6. **Consistência**: Segue padrão Material Design 3

## Melhorias Futuras Possíveis

- [ ] Importar/exportar configurações
- [ ] Backup automático em nuvem
- [ ] Mais opções de cores personalizadas
- [ ] Agendamento de limpezas
- [ ] Estatísticas de uso de espaço
- [ ] Preview de tema em tempo real
- [ ] Suporte a dark mode automático (seguir sistema)
- [ ] Configurações por módulo (cliente, produto, etc.)
