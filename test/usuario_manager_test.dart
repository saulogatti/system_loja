// import 'dart:io';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:system_loja/core/managers/user_repository.dart';

// import 'package:system_loja/core/models/usuario.dart';

// void main() {
//   late UserRepository manager;
//   late String testDataFile;

//   setUp(() {
//     // Cria arquivo temporário para os testes
//     testDataFile =
//         'test/data/test_usuarios_${DateTime.now().millisecondsSinceEpoch}.json';
//     manager = UserRepository(dataFile: testDataFile);
//   });

//   tearDown(() {
//     // Remove arquivo de teste
//     final file = File(testDataFile);
//     if (file.existsSync()) {
//       file.deleteSync();
//     }
//     // Remove diretório se estiver vazio
//     try {
//       Directory('test/data').deleteSync();
//     } catch (_) {}
//   });

//   group('UsuarioManager - Operações CRUD', () {
//     test('Deve adicionar um novo usuário com sucesso', () async {
//       final usuario = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       final sucesso = await manager.adicionarUsuario(usuario);

//       expect(sucesso, isTrue);
//       expect(manager.usuarios.length, equals(1));
//       expect(manager.usuarios.first.nome, equals('João Silva'));
//       expect(manager.usuarios.first.email, equals('joao@example.com'));
//     });

//     test('Não deve adicionar usuário com email duplicado', () async {
//       final usuario1 = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       await manager.adicionarUsuario(usuario1);

//       final usuario2 = Usuario(
//         id: 2,
//         nome: 'João Santos',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('OutraSenha123'),
//         nivelPermissao: NivelPermissao.administrador,
//       );

//       final sucesso = await manager.adicionarUsuario(usuario2);

//       expect(sucesso, isFalse);
//       expect(manager.usuarios.length, equals(1));
//     });

//     test('Deve atualizar um usuário existente', () async {
//       final usuario = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       await manager.adicionarUsuario(usuario);

//       final usuarioAtualizado = usuario.copyWith(
//         nome: 'João Silva Santos',
//         nivelPermissao: NivelPermissao.administrador,
//       );

//       final sucesso = await manager.atualizarUsuario(usuarioAtualizado);

//       expect(sucesso, isTrue);
//       expect(manager.usuarios.first.nome, equals('João Silva Santos'));
//       expect(
//         manager.usuarios.first.nivelPermissao,
//         equals(NivelPermissao.administrador),
//       );
//     });

//     test('Não deve atualizar usuário inexistente', () async {
//       final usuario = Usuario(
//         id: 999,
//         nome: 'Inexistente',
//         email: 'inexistente@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       final sucesso = await manager.atualizarUsuario(usuario);

//       expect(sucesso, isFalse);
//     });

//     test('Deve remover um usuário existente', () async {
//       final usuario = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       await manager.adicionarUsuario(usuario);
//       expect(manager.usuarios.length, equals(1));

//       final sucesso = await manager.removerUsuario(1);

//       expect(sucesso, isTrue);
//       expect(manager.usuarios.length, equals(0));
//     });

//     test('Não deve remover usuário inexistente', () async {
//       final sucesso = await manager.removerUsuario(999);

//       expect(sucesso, isFalse);
//     });
//   });

//   group('UsuarioManager - Consultas', () {
//     setUp(() async {
//       // Adiciona alguns usuários de teste
//       await manager.adicionarUsuario(
//         Usuario(
//           id: 1,
//           nome: 'João Silva',
//           email: 'joao@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );

//       await manager.adicionarUsuario(
//         Usuario(
//           id: 2,
//           nome: 'Maria Santos',
//           email: 'maria@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.administrador,
//         ),
//       );

//       await manager.adicionarUsuario(
//         Usuario(
//           id: 3,
//           nome: 'Pedro Costa',
//           email: 'pedro@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );
//     });

//     test('Deve obter usuário por ID', () {
//       final usuario = manager.obterUsuarioPorId(2);

//       expect(usuario, isNotNull);
//       expect(usuario!.nome, equals('Maria Santos'));
//       expect(usuario.email, equals('maria@example.com'));
//     });

//     test('Deve retornar null para ID inexistente', () {
//       final usuario = manager.obterUsuarioPorId(999);

//       expect(usuario, isNull);
//     });

//     test('Deve obter usuário por email', () {
//       final usuario = manager.obterUsuarioPorEmail('pedro@example.com');

//       expect(usuario, isNotNull);
//       expect(usuario!.nome, equals('Pedro Costa'));
//     });

//     test('Deve retornar null para email inexistente', () {
//       final usuario = manager.obterUsuarioPorEmail('inexistente@example.com');

//       expect(usuario, isNull);
//     });

//     test('Busca por email deve ser case-insensitive', () {
//       final usuario = manager.obterUsuarioPorEmail('PEDRO@EXAMPLE.COM');

//       expect(usuario, isNotNull);
//       expect(usuario!.nome, equals('Pedro Costa'));
//     });

//     test('Deve obter todos os usuários', () {
//       final usuarios = manager.obterTodosUsuarios();

//       expect(usuarios.length, equals(3));
//     });
//   });

//   group('UsuarioManager - Validações', () {
//     test('Deve validar email válido', () {
//       expect(manager.validarEmail('teste@example.com'), isTrue);
//       expect(manager.validarEmail('user.name@domain.co.uk'), isTrue);
//       expect(manager.validarEmail('user+tag@example.com'), isTrue);
//     });

//     test('Deve rejeitar email inválido', () {
//       expect(manager.validarEmail(''), isFalse);
//       expect(manager.validarEmail('invalido'), isFalse);
//       expect(manager.validarEmail('@example.com'), isFalse);
//       expect(manager.validarEmail('teste@'), isFalse);
//       expect(manager.validarEmail('teste@.com'), isFalse);
//     });

//     test('Deve validar senha forte', () {
//       expect(manager.validarSenha('SenhaSegura123'), isNull);
//       expect(manager.validarSenha('Abcdefgh1'), isNull);
//     });

//     test('Deve rejeitar senha fraca', () {
//       expect(manager.validarSenha(''), isNotNull);
//       expect(manager.validarSenha('curta1A'), isNotNull);
//       expect(manager.validarSenha('semminuscula123'), isNotNull);
//       expect(manager.validarSenha('SEMMAIUSCULA123'), isNotNull);
//       expect(manager.validarSenha('SemNumeros'), isNotNull);
//     });

//     test('Deve verificar se email já existe', () {
//       final usuario = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       manager.adicionarUsuario(usuario);

//       expect(manager.emailJaExiste('joao@example.com'), isTrue);
//       expect(manager.emailJaExiste('JOAO@EXAMPLE.COM'), isTrue);
//       expect(manager.emailJaExiste('outro@example.com'), isFalse);
//     });

//     test('Deve verificar email existente ignorando ID específico', () {
//       final usuario1 = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.usuarioComum,
//       );

//       final usuario2 = Usuario(
//         id: 2,
//         nome: 'Maria Santos',
//         email: 'maria@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.administrador,
//       );

//       manager.adicionarUsuario(usuario1);
//       manager.adicionarUsuario(usuario2);

//       // Deve permitir mesmo email do próprio usuário
//       expect(manager.emailJaExiste('joao@example.com', ignorarId: 1), isFalse);
//       // Deve detectar email de outro usuário
//       expect(manager.emailJaExiste('maria@example.com', ignorarId: 1), isTrue);
//     });
//   });

//   group('UsuarioManager - Segurança', () {
//     test('Deve gerar hash SHA-256 da senha', () {
//       final senha = 'MinhaSenhaSegura123';
//       final hash = manager.hashSenha(senha);

//       expect(hash, isNotEmpty);
//       expect(
//         hash,
//         hasLength(64),
//       ); // SHA-256 produz hash de 64 caracteres em hex
//       expect(hash, isNot(equals(senha)));
//     });

//     test('Mesmo senha deve gerar mesmo hash', () {
//       final senha = 'MinhaSenhaSegura123';
//       final hash1 = manager.hashSenha(senha);
//       final hash2 = manager.hashSenha(senha);

//       expect(hash1, equals(hash2));
//     });

//     test('Senhas diferentes devem gerar hashes diferentes', () {
//       final hash1 = manager.hashSenha('SenhaUm123');
//       final hash2 = manager.hashSenha('SenhaDois123');

//       expect(hash1, isNot(equals(hash2)));
//     });

//     test('Deve verificar senha corretamente', () {
//       final senha = 'MinhaSenhaSegura123';
//       final hash = manager.hashSenha(senha);

//       expect(manager.verificarSenha(senha, hash), isTrue);
//       expect(manager.verificarSenha('SenhaErrada123', hash), isFalse);
//     });
//   });

//   group('UsuarioManager - Geração de ID', () {
//     test('Deve gerar ID 1 para lista vazia', () {
//       expect(manager.gerarProximoId(), equals(1));
//     });

//     test('Deve gerar próximo ID sequencial', () async {
//       await manager.adicionarUsuario(
//         Usuario(
//           id: 1,
//           nome: 'Usuario 1',
//           email: 'user1@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );

//       await manager.adicionarUsuario(
//         Usuario(
//           id: 2,
//           nome: 'Usuario 2',
//           email: 'user2@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );

//       expect(manager.gerarProximoId(), equals(3));
//     });

//     test('Deve gerar ID maior que o máximo existente', () async {
//       await manager.adicionarUsuario(
//         Usuario(
//           id: 5,
//           nome: 'Usuario 5',
//           email: 'user5@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );

//       await manager.adicionarUsuario(
//         Usuario(
//           id: 10,
//           nome: 'Usuario 10',
//           email: 'user10@example.com',
//           senhaHash: manager.hashSenha('SenhaSegura123'),
//           nivelPermissao: NivelPermissao.usuarioComum,
//         ),
//       );

//       expect(manager.gerarProximoId(), equals(11));
//     });
//   });

//   group('UsuarioManager - Persistência', () {
//     test('Deve salvar e carregar dados do arquivo JSON', () async {
//       final usuario = Usuario(
//         id: 1,
//         nome: 'João Silva',
//         email: 'joao@example.com',
//         senhaHash: manager.hashSenha('SenhaSegura123'),
//         nivelPermissao: NivelPermissao.administrador,
//       );

//       await manager.adicionarUsuario(usuario);

//       // Cria novo manager apontando para o mesmo arquivo
//       final novoManager = UserRepository(dataFile: testDataFile);

//       expect(novoManager.usuarios.length, equals(1));
//       expect(novoManager.usuarios.first.nome, equals('João Silva'));
//       expect(novoManager.usuarios.first.email, equals('joao@example.com'));
//       expect(
//         novoManager.usuarios.first.nivelPermissao,
//         equals(NivelPermissao.administrador),
//       );
//     });
//   });
// }
