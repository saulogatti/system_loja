// import 'dart:io';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:system_loja/core/managers/log_atividade_manager.dart';
// import 'package:system_loja/core/models/log_atividade.dart';

// void main() {
//   late LogAtividadeManager manager;
//   late String testDataFile;

//   setUp(() {
//     // Cria arquivo temporário para os testes
//     testDataFile = 'test/data/test_logs_${DateTime.now().millisecondsSinceEpoch}.json';
//     manager = LogAtividadeManager(dataFile: testDataFile);
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

//   group('LogAtividadeManager - Registro de Logs', () {
//     test('Deve registrar um novo log de atividade', () async {
//       final log = LogAtividade(
//         id: 1,
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'João Silva',
//         detalhes: 'Usuário criado com sucesso',
//       );

//       await manager.registrarLog(log);

//       expect(manager.logs.length, equals(1));
//       expect(manager.logs.first.tipoAcao, equals(TipoAcao.criar));
//       expect(manager.logs.first.entidade, equals('Usuario'));
//     });

//     test('Deve criar e registrar log automaticamente', () async {
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.atualizar,
//         entidade: 'Produto',
//         entidadeId: 5,
//         usuarioId: 2,
//         usuarioNome: 'Maria Santos',
//         detalhes: 'Produto atualizado',
//       );

//       expect(manager.logs.length, equals(1));
//       expect(manager.logs.first.tipoAcao, equals(TipoAcao.atualizar));
//       expect(manager.logs.first.entidade, equals('Produto'));
//       expect(manager.logs.first.entidadeId, equals(5));
//     });

//     test('Deve registrar múltiplos logs', () async {
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.atualizar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.deletar,
//         entidade: 'Produto',
//         entidadeId: 5,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       expect(manager.logs.length, equals(3));
//     });
//   });

//   group('LogAtividadeManager - Consultas', () {
//     setUp(() async {
//       // Adiciona logs de teste
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//         detalhes: 'Usuário 1 criado',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.atualizar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//         detalhes: 'Usuário 1 atualizado',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Produto',
//         entidadeId: 5,
//         usuarioId: 2,
//         usuarioNome: 'Maria',
//         detalhes: 'Produto 5 criado',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.deletar,
//         entidade: 'Cliente',
//         entidadeId: 10,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//         detalhes: 'Cliente 10 deletado',
//       );
//     });

//     test('Deve obter todos os logs', () {
//       final logs = manager.obterTodosLogs();

//       expect(logs.length, equals(4));
//     });

//     test('Deve obter logs por usuário', () {
//       final logsAdmin = manager.obterLogsPorUsuario(1);
//       final logsMaria = manager.obterLogsPorUsuario(2);

//       expect(logsAdmin.length, equals(3));
//       expect(logsMaria.length, equals(1));
//       expect(logsMaria.first.usuarioNome, equals('Maria'));
//     });

//     test('Deve obter logs por entidade', () {
//       final logsUsuario = manager.obterLogsPorEntidade('Usuario');
//       final logsProduto = manager.obterLogsPorEntidade('Produto');
//       final logsCliente = manager.obterLogsPorEntidade('Cliente');

//       expect(logsUsuario.length, equals(2));
//       expect(logsProduto.length, equals(1));
//       expect(logsCliente.length, equals(1));
//     });

//     test('Deve obter logs por entidade e ID específico', () {
//       final logsUsuario1 = manager.obterLogsPorEntidade('Usuario', entidadeId: 1);
//       final logsProduto5 = manager.obterLogsPorEntidade('Produto', entidadeId: 5);

//       expect(logsUsuario1.length, equals(2));
//       expect(logsProduto5.length, equals(1));
//       expect(logsProduto5.first.entidadeId, equals(5));
//     });

//     test('Deve obter logs por tipo de ação', () {
//       final logsCriar = manager.obterLogsPorTipoAcao(TipoAcao.criar);
//       final logsAtualizar = manager.obterLogsPorTipoAcao(TipoAcao.atualizar);
//       final logsDeletar = manager.obterLogsPorTipoAcao(TipoAcao.deletar);

//       expect(logsCriar.length, equals(2));
//       expect(logsAtualizar.length, equals(1));
//       expect(logsDeletar.length, equals(1));
//     });

//     test('Deve obter logs por período', () {
//       final agora = DateTime.now();
//       final umDiaAtras = agora.subtract(const Duration(days: 1));
//       final umDiaDepois = agora.add(const Duration(days: 1));

//       final logs = manager.obterLogsPorPeriodo(umDiaAtras, umDiaDepois);

//       expect(logs.length, equals(4));
//     });

//     test('Deve retornar lista vazia para período sem logs', () {
//       final doisDiasAtras = DateTime.now().subtract(const Duration(days: 2));
//       final umDiaAtras = DateTime.now().subtract(const Duration(days: 1));

//       final logs = manager.obterLogsPorPeriodo(doisDiasAtras, umDiaAtras);

//       expect(logs.length, equals(0));
//     });
//   });

//   group('LogAtividadeManager - Limpeza de Logs', () {
//     test('Deve limpar logs antigos', () async {
//       final dataAtual = DateTime.now();
//       final dataAntiga = dataAtual.subtract(const Duration(days: 31));

//       // Cria log antigo manualmente
//       final logAntigo = LogAtividade(
//         id: 1,
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//         dataHora: dataAntiga,
//       );

//       await manager.registrarLog(logAntigo);

//       // Cria log recente
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Produto',
//         entidadeId: 5,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       expect(manager.logs.length, equals(2));

//       // Limpa logs com mais de 30 dias
//       final dataLimite = dataAtual.subtract(const Duration(days: 30));
//       await manager.limparLogsAntigos(dataLimite);

//       expect(manager.logs.length, equals(1));
//       expect(manager.logs.first.entidade, equals('Produto'));
//     });
//   });

//   group('LogAtividadeManager - Geração de ID', () {
//     test('Deve gerar ID 1 para lista vazia', () {
//       expect(manager.gerarProximoId(), equals(1));
//     });

//     test('Deve gerar próximo ID sequencial', () async {
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 2,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//       );

//       expect(manager.gerarProximoId(), equals(3));
//     });
//   });

//   group('LogAtividadeManager - Persistência', () {
//     test('Deve salvar e carregar dados do arquivo JSON', () async {
//       await manager.criarERegistrarLog(
//         tipoAcao: TipoAcao.criar,
//         entidade: 'Usuario',
//         entidadeId: 1,
//         usuarioId: 1,
//         usuarioNome: 'Admin',
//         detalhes: 'Teste de persistência',
//       );

//       // Cria novo manager apontando para o mesmo arquivo
//       final novoManager = LogAtividadeManager(dataFile: testDataFile);

//       expect(novoManager.logs.length, equals(1));
//       expect(novoManager.logs.first.entidade, equals('Usuario'));
//       expect(novoManager.logs.first.usuarioNome, equals('Admin'));
//       expect(novoManager.logs.first.detalhes, equals('Teste de persistência'));
//     });

//     test('Deve preservar todos os dados do log ao persistir', () async {
//       final dataHora = DateTime.now();
//       final log = LogAtividade(
//         id: 1,
//         tipoAcao: TipoAcao.atualizar,
//         entidade: 'Produto',
//         entidadeId: 5,
//         usuarioId: 2,
//         usuarioNome: 'Maria Santos',
//         dataHora: dataHora,
//         detalhes: 'Produto atualizado com novos valores',
//       );

//       await manager.registrarLog(log);

//       // Cria novo manager apontando para o mesmo arquivo
//       final novoManager = LogAtividadeManager(dataFile: testDataFile);

//       final logCarregado = novoManager.logs.first;
//       expect(logCarregado.id, equals(1));
//       expect(logCarregado.tipoAcao, equals(TipoAcao.atualizar));
//       expect(logCarregado.entidade, equals('Produto'));
//       expect(logCarregado.entidadeId, equals(5));
//       expect(logCarregado.usuarioId, equals(2));
//       expect(logCarregado.usuarioNome, equals('Maria Santos'));
//       expect(logCarregado.detalhes, equals('Produto atualizado com novos valores'));
//     });
//   });
// }
