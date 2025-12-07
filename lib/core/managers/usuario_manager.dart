import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';

import '../models/usuario.dart';

/// Gerenciador de Usuários
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
/// Implementa funcionalidades de hash de senha para segurança.
class UsuarioManager with LoggerClassMixin {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  final String dataFile;

  List<Usuario> usuarios = [];

  UsuarioManager({this.dataFile = 'data/usuarios.json'}) {
    _carregarDados();
  }

  /// Obtém um usuário por ID
  Usuario? obterUsuarioPorId(int id) {
    return usuarios.where((u) => u.id == id).firstOrNull;
  }

  /// Obtém um usuário por email
  Usuario? obterUsuarioPorEmail(String email) {
    return usuarios.where((u) => u.email.toLowerCase() == email.toLowerCase()).firstOrNull;
  }

  /// Obtém todos os usuários
  List<Usuario> obterTodosUsuarios() {
    return usuarios;
  }

  /// Verifica se um email já está em uso
  bool emailJaExiste(String email, {int? ignorarId}) {
    return usuarios.any((u) => u.email.toLowerCase() == email.toLowerCase() && u.id != ignorarId);
  }

  /// Valida o formato do email
  bool validarEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Valida a força da senha
  ///
  /// Retorna uma mensagem de erro se a senha for inválida, ou null se for válida.
  String? validarSenha(String senha) {
    if (senha.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (senha.length < 8) {
      return 'Senha deve ter no mínimo 8 caracteres';
    }
    if (!senha.contains(RegExp(r'[A-Z]'))) {
      return 'Senha deve conter pelo menos uma letra maiúscula';
    }
    if (!senha.contains(RegExp(r'[a-z]'))) {
      return 'Senha deve conter pelo menos uma letra minúscula';
    }
    if (!senha.contains(RegExp(r'[0-9]'))) {
      return 'Senha deve conter pelo menos um número';
    }
    return null;
  }

  /// Gera hash SHA-256 da senha
  String hashSenha(String senha) {
    final bytes = utf8.encode(senha);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifica se a senha corresponde ao hash armazenado
  bool verificarSenha(String senha, String senhaHash) {
    return hashSenha(senha) == senhaHash;
  }

  /// Adiciona um novo usuário
  ///
  /// A senha será automaticamente convertida em hash antes de salvar.
  /// Retorna true se o usuário foi adicionado com sucesso.
  Future<bool> adicionarUsuario(Usuario usuario) async {
    // Valida se o email já existe
    if (emailJaExiste(usuario.email)) {
      logWarning('Tentativa de adicionar usuário com email duplicado: ${usuario.email}');
      return false;
    }

    usuarios.add(usuario);
    await salvarDadosSincronizado();
    logInfo('Usuário adicionado com sucesso: ${usuario.email}');
    return true;
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  Future<bool> atualizarUsuario(Usuario usuario) async {
    final index = usuarios.indexWhere((u) => u.id == usuario.id);
    if (index == -1) {
      logWarning('Tentativa de atualizar usuário inexistente: ID ${usuario.id}');
      return false;
    }

    // Valida se o email já existe (excluindo o próprio usuário)
    if (emailJaExiste(usuario.email, ignorarId: usuario.id)) {
      logWarning('Tentativa de atualizar usuário com email duplicado: ${usuario.email}');
      return false;
    }

    usuarios[index] = usuario.copyWith(dataUltimaAtualizacao: DateTime.now());
    await salvarDadosSincronizado();
    logInfo('Usuário atualizado com sucesso: ${usuario.email}');
    return true;
  }

  /// Remove um usuário pelo ID
  ///
  /// Retorna true se o usuário foi removido com sucesso.
  Future<bool> removerUsuario(int id) async {
    final index = usuarios.indexWhere((u) => u.id == id);
    if (index == -1) {
      logWarning('Tentativa de remover usuário inexistente: ID $id');
      return false;
    }

    final usuario = usuarios[index];
    usuarios.removeAt(index);
    await salvarDadosSincronizado();
    logInfo('Usuário removido com sucesso: ${usuario.email}');
    return true;
  }

  /// Gera o próximo ID disponível
  int gerarProximoId() {
    if (usuarios.isEmpty) {
      return 1;
    }
    return usuarios.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  /// Public method to save data (for Flutter GUI)
  @Deprecated('Use salvarDadosSincronizado() para operações seguras')
  void salvarDados() => _salvarDados();

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
      for (final u in dadosAtuais) {
        if (u.id > maiorId) {
          maiorId = u.id;
        }
      }

      // Mescla dados: atualiza itens existentes e adiciona novos com IDs únicos
      for (final usuario in usuarios) {
        final index = dadosAtuais.indexWhere((u) => u.id == usuario.id);
        if (index >= 0) {
          // Atualiza item existente
          dadosAtuais[index] = usuario;
        } else {
          // Verifica se o ID já existe (conflito) e reatribui se necessário
          final idExistente = dadosAtuais.any((u) => u.id == usuario.id);
          if (idExistente) {
            maiorId++;
            final usuarioComNovoId = usuario.copyWith(id: maiorId);
            dadosAtuais.add(usuarioComNovoId);
          } else {
            dadosAtuais.add(usuario);
            if (usuario.id > maiorId) {
              maiorId = usuario.id;
            }
          }
        }
      }

      // Atualiza cache em memória com dados mesclados
      usuarios = dadosAtuais;

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
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        usuarios = jsonList.map((json) => Usuario.fromJson(json as Map<String, dynamic>)).toList();
      } catch (e, stackTrace) {
        logError('Erro ao carregar dados de usuários: $e', stackTrace);
        usuarios = [];
      }
    }
  }

  /// Carrega dados do disco sem modificar o estado interno
  List<Usuario> _carregarDadosDoDisco() {
    final file = File(dataFile);
    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        return jsonList.map((json) => Usuario.fromJson(json as Map<String, dynamic>)).toList();
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
    final jsonString = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
    file.writeAsStringSync(jsonString);
  }
}
