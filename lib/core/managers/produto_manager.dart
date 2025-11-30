import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/models/produto.dart';

/// Gerencia operações de CRUD e persistência para produtos.
///
/// Esta classe implementa um gerenciador simples de produtos que armazena
/// os itens em um arquivo JSON (por padrão `data/produtos.json`). Ela usa um
/// mecanismo de lock por arquivo para serializar acesso concorrente entre
/// múltiplas instâncias em execução e realiza carregamento/mesclagem de
/// dados antes de persistir para reduzir risco de perda por sobrescrita.
///
/// Para lidar com concorrência entre processos diferentes, esta classe
/// utiliza bloqueio de arquivo (file locking) via [RandomAccessFile.lock],
/// além do lock em memória do pacote `synchronized` para isolates.
class ProdutoManager with LoggerClassMixin {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O
  /// entre múltiplas instâncias do gerenciador na mesma aplicação.
  static final Map<String, Lock> _fileLocks = {};

  /// Caminho do arquivo JSON usado para persistir os produtos.
  ///
  /// Valor padrão: `data/produtos.json`. Pode ser sobrescrito para testes
  /// ou ambientes alternativos ao instanciar o gerenciador.
  final String dataFile;

  /// Cache em memória da lista de produtos carregada do arquivo.
  List<Produto> _produtos = [];

  /// Cria uma instância de [ProdutoManager] e carrega os dados do arquivo.
  ///
  /// O parâmetro [dataFile] permite apontar para um arquivo alternativo.
  ProdutoManager({this.dataFile = 'data/produtos.json'}) {
    _produtos = _carregarDadosDoDisco();
  }

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.
  List<Produto> get _produtosList {
    if (_produtos.isEmpty) {
      _produtos = _carregarDadosDoDisco();
    }
    return _produtos;
  }

  /// Gera um novo ID incremental com base nos IDs existentes.
  ///
  /// Utiliza a lista em memória para calcular o próximo ID disponível.
  /// Retorna `1` quando não há produtos cadastrados.
  int gerarNovoId() {
    if (_produtosList.isEmpty) {
      return 1;
    } else {
      return _produtosList.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  List<Produto> getProdutos() {
    return List<Produto>.from(_produtosList);
  }

  /// Busca um produto pelo seu código externo.
  ///
  /// Retorna o [Produto] correspondente ou `null` caso não exista. Em caso
  /// de falha a operação registra uma mensagem de informação usando o
  /// `LoggerClassMixin`.
  Produto? getProdutosPorCodigo(String codigo) {
    try {
      return _produtosList.firstWhere((produto) => produto.codigo == codigo);
    } catch (e) {
      logInfo('Produto com código $codigo não encontrado.');
      return null;
    }
  }

  /// Salva os dados de forma sincronizada aplicando merge seguro.
  ///
  /// Este método adquire um lock por arquivo para evitar condições de corrida
  /// em acesso concorrente. Antes de sobrescrever o arquivo, ele recarrega
  /// os dados do disco e mescla os itens em memória com os existentes no
  /// arquivo, atualizando itens por `id` e atribuindo novos IDs a itens
  /// recém-adicionados quando necessário. Em caso de erro o stack trace é
  /// registrado via `logError`.
  ///
  /// O método usa bloqueio de arquivo (file locking) via [RandomAccessFile]
  /// para garantir exclusividade entre processos diferentes, além do lock
  /// em memória do pacote `synchronized` para isolates no mesmo processo.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      await _executarComFileLock(() async {
        // Recarrega dados do arquivo para obter a versão mais recente
        final dadosAtuais = _carregarDadosDoDisco();

        // Obtém o maior ID existente para evitar conflitos
        int maiorId = 0;
        for (final p in dadosAtuais) {
          if (p.id > maiorId) {
            maiorId = p.id;
          }
        }

        // Mescla dados: atualiza itens existentes e adiciona novos
        for (final produto in _produtosList) {
          final index = dadosAtuais.indexWhere((p) => p.id == produto.id);
          if (index >= 0) {
            // Atualiza item existente
            dadosAtuais[index] = produto;
          } else {
            // Verifica se o ID já existe (conflito) e reatribui se necessário
            final idExistente = dadosAtuais.any((p) => p.id == produto.id);
            if (idExistente) {
              maiorId++;
              final produtoComNovoId = Produto(
                id: maiorId,
                nome: produto.nome,
                codigo: produto.codigo,
                preco: produto.preco,
                estoque: produto.estoque,
                descricao: produto.descricao,
                categoria: produto.categoria,
                dataCadastro: produto.dataCadastro,
              );
              dadosAtuais.add(produtoComNovoId);
            } else {
              dadosAtuais.add(produto);
              if (produto.id > maiorId) {
                maiorId = produto.id;
              }
            }
          }
        }

        // Atualiza cache em memória com dados mesclados
        _produtos = dadosAtuais;

        // Salva dados mesclados no arquivo
        _salvarDados();
      });
    });
  }

  /// Adiciona ou atualiza um produto na lista em memória e agenda persistência.
  ///
  /// Este método atualiza o cache interno e chama [salvarDadosSincronizado]
  /// para persistir as alterações de forma segura. Não aguarda o término da
  /// operação (fire-and-forget) — adaptar conforme necessidade do chamador.
  void salvarProduto(Produto produto) {
    final index = _produtos.indexWhere((p) => p.id == produto.id);
    if (index >= 0) {
      _produtos[index] = produto;
    } else {
      _produtos.add(produto);
    }
    salvarDadosSincronizado();
  }

  /// Lê o arquivo JSON e retorna a lista de produtos atualmente armazenada.
  ///
  /// Em caso de erro de leitura ou parsing a função registra o erro e
  /// retorna uma lista vazia. Esta função não altera o estado público além
  /// de retornar o conteúdo lido; o cache em memória só é atualizado por
  /// quem chamar explicitamente.
  List<Produto> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Produto.fromJson(json)).toList();
      } catch (e, stackTrace) {
        logError('Erro ao carregar dados de produtos do disco: $e', stackTrace);
        return [];
      }
    }
    return [];
  }

  /// Executa uma operação com bloqueio exclusivo de arquivo.
  ///
  /// Utiliza um arquivo de lock (`.lock`) para garantir exclusividade entre
  /// processos diferentes. O arquivo de lock é criado ao lado do arquivo
  /// de dados e é bloqueado de forma exclusiva durante a operação.
  ///
  /// Em caso de falha ao adquirir o lock, a operação é abortada e a exceção
  /// é relançada para evitar corrupção de dados.
  Future<T> _executarComFileLock<T>(Future<T> Function() operacao) async {
    final lockFile = File('$dataFile.lock');
    RandomAccessFile? raf;
    var lockAcquired = false;
    try {
      // Garante que o diretório pai existe
      lockFile.parent.createSync(recursive: true);

      // Cria ou abre o arquivo de lock
      raf = lockFile.openSync(mode: FileMode.write);

      // Tenta adquirir lock exclusivo
      await raf.lock(FileLock.blockingExclusive);
      lockAcquired = true;

      // Executa a operação protegida
      return await operacao();
    } on FileSystemException catch (e, stackTrace) {
      // Se não conseguiu adquirir o lock, a operação deve falhar para evitar
      // corrupção de dados
      logError(
        'Falha crítica ao adquirir lock de arquivo: $e. '
        'A operação será abortada.',
        stackTrace,
      );
      rethrow;
    } finally {
      // Libera o lock apenas se foi adquirido com sucesso
      if (raf != null) {
        if (lockAcquired) {
          try {
            await raf.unlock();
          } catch (_) {
            // Ignora erro ao desbloquear
          }
        }
        try {
          await raf.close();
        } catch (_) {
          // Ignora erro ao fechar
        }
      }
    }
  }

  /// Retorna o [Lock] associado ao arquivo de dados, criando se necessário.
  ///
  /// O lock é usado para serializar operações de leitura/escrita no arquivo
  /// entre múltiplas instâncias do gerenciador dentro do mesmo processo.
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, () => Lock());
  }

  /// Persiste o cache atual (`_produtosList`) no arquivo JSON.
  ///
  /// A função cria diretórios pai quando necessário e registra erros via
  /// `logError` em caso de falha de I/O. Ela utiliza escrita síncrona para
  /// simplificar a operação e manter comportamento determinístico.
  void _salvarDados() {
    try {
      final file = File(dataFile);
      file.parent.createSync(recursive: true);
      final jsonString = jsonEncode(
        _produtosList.map((produto) => produto.toJson()).toList(),
      );
      file.writeAsStringSync(jsonString);
    } catch (e, stackTrace) {
      logError('Erro ao salvar dados de produtos: $e', stackTrace);
    }
  }
}
