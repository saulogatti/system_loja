# Configuração MCP (Model Context Protocol) - System Loja

## O que é MCP?

O Model Context Protocol (MCP) é um protocolo que permite que ferramentas de IA, como o GitHub Copilot, acessem contexto adicional sobre seu projeto através de servidores especializados. Isso pode incluir:

- Acesso a bancos de dados
- APIs internas
- Documentação específica
- Ferramentas de desenvolvimento customizadas
- Contexto de negócio específico

## Status Atual

**Atualmente, este projeto não utiliza servidores MCP configurados.**

O System Loja é um projeto relativamente simples que usa:
- Persistência de dados em arquivos JSON locais
- Sem integração com APIs externas
- Sem bancos de dados externos (exceto suporte opcional a SQLite)
- Documentação completa disponível no repositório

Para a maioria dos casos de uso do GitHub Copilot Coding Agent, a configuração atual é suficiente, pois:

1. **Contexto do repositório** está disponível via arquivos `.md` e código-fonte
2. **Instruções para o Copilot** estão em `.github/copilot-instructions.md`
3. **Padrões de código** estão documentados em `.github/instructions/`
4. **Guia de contribuição** está em `CONTRIBUTING.md`

---

## Quando Considerar MCP Servers

Você deve considerar configurar servidores MCP para este projeto se:

### Cenários Potenciais

1. **Integração com Backend Externo**
   - Se o projeto evoluir para usar uma API REST externa
   - Se precisar acessar serviços de autenticação centralizados
   - Se houver integração com sistemas ERP

2. **Banco de Dados Compartilhado**
   - Se migrar para PostgreSQL, MySQL, ou outro SGBD
   - Se precisar consultar dados de produção para desenvolvimento
   - Se houver necessidade de schemas complexos

3. **Ferramentas Internas**
   - Scripts de migração de dados específicos
   - Ferramentas de análise de logs
   - Sistemas de monitoramento customizados

4. **Documentação Externa**
   - Wiki corporativo
   - Confluence ou SharePoint
   - Documentação de APIs proprietárias

---

## Como Configurar MCP Servers (Futuro)

Se você decidir implementar servidores MCP no futuro, siga estas diretrizes:

### 1. Escolha o Tipo de Servidor

**Servidores MCP Comuns:**
- **Database MCP**: Para acesso a bancos de dados
- **Filesystem MCP**: Para acesso a arquivos fora do repositório
- **API MCP**: Para integração com APIs REST
- **Custom MCP**: Para ferramentas específicas do projeto

### 2. Configuração Básica

Crie um arquivo de configuração `.github/mcp-config.json`:

```json
{
  "mcpServers": {
    "database": {
      "type": "database",
      "config": {
        "connectionString": "${DATABASE_URL}",
        "readonly": true
      }
    },
    "filesystem": {
      "type": "filesystem",
      "config": {
        "rootPath": "${PROJECT_DATA_PATH}",
        "allowedExtensions": [".json", ".csv", ".txt"]
      }
    }
  }
}
```

### 3. Segurança

**⚠️ IMPORTANTE: Nunca commit credenciais ou dados sensíveis!**

- Use variáveis de ambiente para credenciais
- Configure acesso somente leitura sempre que possível
- Implemente rate limiting para evitar sobrecarga
- Use conexões criptografadas (TLS/SSL)
- Restrinja acesso a dados de produção

### 4. Documentação para o Copilot

Atualize `.github/copilot-instructions.md` com informações sobre os servidores MCP:

```markdown
## MCP Servers Disponíveis

### Database Server
- **Propósito**: Consulta a base de dados de produção (somente leitura)
- **Como usar**: Pergunte ao Copilot sobre dados específicos
- **Limitações**: Sem acesso de escrita, máximo 100 registros por consulta

### Filesystem Server
- **Propósito**: Acesso a arquivos de dados históricos
- **Como usar**: Solicite análise de logs ou dados antigos
- **Limitações**: Somente arquivos em /data/historico/
```

---

## Exemplos de Uso (Hipotético)

Se o projeto tivesse servidores MCP configurados, você poderia:

### Consultar Dados

```
@copilot Quantos clientes foram cadastrados no último mês segundo o banco de dados?
```

*O Copilot usaria o Database MCP Server para consultar dados reais.*

### Analisar Arquivos Externos

```
@copilot Analise os logs de erro do último deploy em /logs/prod/errors.log
```

*O Copilot usaria o Filesystem MCP Server para acessar logs.*

### Integrar com APIs

```
@copilot Busque as últimas notas fiscais emitidas pela API fiscal
```

*O Copilot usaria o API MCP Server para fazer chamadas REST.*

---

## Recursos para Aprender Mais

Quando estiver pronto para implementar servidores MCP:

- **MCP Specification**: https://modelcontextprotocol.io/
- **GitHub Copilot MCP Docs**: https://docs.github.com/en/copilot/customizing-copilot/using-mcp-servers
- **MCP Server Examples**: https://github.com/modelcontextprotocol/servers
- **Community Servers**: https://github.com/topics/mcp-server

---

## Contribuindo

Se você implementar servidores MCP para este projeto:

1. **Documente** a configuração neste arquivo
2. **Atualize** `.github/copilot-instructions.md` com instruções de uso
3. **Adicione** testes para validar a conexão
4. **Configure** variáveis de ambiente no CI/CD
5. **Revise** as permissões de segurança

---

## Contato

Para questões sobre MCP servers:
- Abra uma issue com a label `question` e `mcp`
- Consulte a documentação oficial do MCP
- Entre em contato com o mantenedor do projeto

---

**Nota**: Este arquivo será atualizado quando/se servidores MCP forem implementados no projeto.

*Última atualização: 2025-12-07*
