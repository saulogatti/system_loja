import 'dart:convert';
import 'dart:io';

import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/models/nota_fiscal.dart';

/// Gerenciador de Notas Fiscais
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class NotaFiscalManager {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  List<NotaFiscal> notasFiscais = [];

  NotaFiscalManager({this.dataFile = 'data/notas_fiscais.json'}) {
    _carregarDados();
  }

  /// Salva dados de forma segura e sincronizada (para Flutter GUI)
  ///
  /// Utiliza um lock para serializar o acesso ao arquivo e recarrega
  /// os dados antes de salvar para mesclar alterações de outras instâncias.
  /// Resolve conflitos de ID atribuindo novos IDs para itens novos.
  Future<void> salvarDadosSincronizado() async {
    await _getLock().synchronized(() async {
      // Recarrega dados do arquivo para obter a versão mais recente
      final dadosAtuais = _carregarDadosDoDisco();

      // Obtém o maior ID existente para evitar conflitos
      int maiorId = 0;
      for (final nf in dadosAtuais) {
        if (nf.id > maiorId) {
          maiorId = nf.id;
        }
      }

      // Mescla dados: atualiza itens existentes e adiciona novos com IDs únicos
      for (final notaFiscal in notasFiscais) {
        final index = dadosAtuais.indexWhere((nf) => nf.id == notaFiscal.id);
        if (index >= 0) {
          // Atualiza item existente
          dadosAtuais[index] = notaFiscal;
        } else {
          // Verifica se o ID já existe (conflito) e reatribui se necessário
          final idExistente = dadosAtuais.any((nf) => nf.id == notaFiscal.id);
          if (idExistente) {
            maiorId++;
            final notaFiscalComNovoId = NotaFiscal(
              id: maiorId,
              numeroNota: notaFiscal.numeroNota,
              clienteId: notaFiscal.clienteId,
              clienteNome: notaFiscal.clienteNome,
              clienteCpf: notaFiscal.clienteCpf,
              itens: notaFiscal.itens,
              formaPagamento: notaFiscal.formaPagamento,
              dataEmissao: notaFiscal.dataEmissao,
            );
            dadosAtuais.add(notaFiscalComNovoId);
          } else {
            dadosAtuais.add(notaFiscal);
            if (notaFiscal.id > maiorId) {
              maiorId = notaFiscal.id;
            }
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      notasFiscais = dadosAtuais;

      // Salva dados mesclados no arquivo
      _salvarDados();
    });
  }

  /// Carrega dados do arquivo JSON
  void _carregarDados() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<Map<String, dynamic>> jsonList = jsonDecode(jsonString) as List<Map<String, dynamic>>;
        notasFiscais = jsonList.map(NotaFiscal.fromJson).toList();
      } catch (e) {
        print('Erro ao carregar dados de notas fiscais: $e');
        notasFiscais = [];
      }
    }
  }

  /// Carrega dados do disco sem modificar o estado interno
  List<NotaFiscal> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<Map<String, dynamic>> jsonList = jsonDecode(jsonString) as List<Map<String, dynamic>>;
        return jsonList.map(NotaFiscal.fromJson).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(dataFile, Lock.new);
  }

  /// Salva dados no arquivo JSON de forma segura
  ///
  /// Recarrega os dados do arquivo antes de salvar para mesclar com alterações
  /// feitas por outras instâncias, evitando perda de dados.
  void _salvarDados() {
    final file = File(dataFile);
    file.parent.createSync(recursive: true);
    final jsonString = jsonEncode(notasFiscais.map((nf) => nf.toJson()).toList());
    file.writeAsStringSync(jsonString);
  }
}
