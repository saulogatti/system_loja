import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/domain/repository/configuration_repository.dart';
import 'package:system_loja/domain/repository/system/log_repository.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

void main() {
  late ConfigurationRepository manager;
  late String testDataFile;
  late SystemDatabase systemDatabase;
  setUp(() {
    systemDatabase = SystemDatabase();
    // Cria arquivo temporário para os testes
    testDataFile =
        'test/data/test_configuracao_${DateTime.now().millisecondsSinceEpoch}.json';
    // TODO arquivo de teste, checar se é necessário criar ou gerar mock de cache e banco de dados
    manager = ConfigurationRepository(
      logRepository: LogRepository(logDao: systemDatabase.logDao),
      settingsService: SettingsService.injection(),
    );
  });

  tearDown(() {
    // Remove arquivo de teste
    final file = File(testDataFile);
    if (file.existsSync()) {
      file.deleteSync();
    }
    // Remove diretório de backups de teste
    try {
      Directory('data/backups').deleteSync(recursive: true);
    } catch (_) {}
    // Remove diretório se estiver vazio
    try {
      Directory('test/data').deleteSync();
    } catch (e) {
      // Ignora erro se diretório não estiver vazio ou não existir
    }
  });

  group('ConfiguracaoManager - Operações Básicas', () {
    test('Deve carregar configurações padrão na primeira execução', () async {
      final config = await manager.loadConfiguration();

      expect(config.notificacoesAtivadas, isTrue);
      expect(config.temaEscuro, isFalse);
      expect(config.limiteEstoqueBaixo, equals(10));
    });

    test('Deve atualizar configurações com sucesso', () async {
      final currentConfig = await manager.loadConfiguration();
      final novaConfig = currentConfig.copyWith(
        temaEscuro: true,

        notificarVendas: false,
      );

      await manager.updateAppSettings(novaConfig);

      final updatedConfig = await manager.loadConfiguration();

      expect(updatedConfig.temaEscuro, isTrue);

      expect(updatedConfig.notificarVendas, isFalse);
    });

    test('Deve persistir configurações após salvar', () async {
      final currentConfig = await manager.loadConfiguration();
      final novaConfig = currentConfig.copyWith(
        limiteEstoqueBaixo: 25,
        frequenciaBackup: 'mensal',
      );

      await manager.updateAppSettings(novaConfig);

      // Cria novo manager para verificar persistência
      final manager2 = ConfigurationRepository(
        logRepository: LogRepository(logDao: systemDatabase.logDao),
        settingsService: SettingsService.injection(),
      );

      final updatedConfig2 = await manager2.loadConfiguration();

      expect(updatedConfig2.limiteEstoqueBaixo, equals(25));
      expect(updatedConfig2.frequenciaBackup, equals('mensal'));
    });

    test('Deve restaurar configurações padrão', () async {
      // Primeiro altera as configurações
      final currentConfig = await manager.loadConfiguration();
      final novaConfig = currentConfig.copyWith(
        temaEscuro: true,
        limiteEstoqueBaixo: 50,
      );
      await manager.updateAppSettings(novaConfig);

      // Depois restaura padrão
      await manager.resetToDefaults();

      final restoredConfig = await manager.loadConfiguration();

      expect(restoredConfig.temaEscuro, isFalse);
      expect(restoredConfig.limiteEstoqueBaixo, equals(10));
    });
  });

  group('ConfiguracaoManager - Backup de Dados', () {
    test('Deve criar estrutura de diretório para backup', () async {
      // Cria alguns arquivos de dados para backup
      Directory('data').createSync(recursive: true);
      File('data/clientes.json').writeAsStringSync('[]');
      File('data/produtos.json').writeAsStringSync('[]');

      final sucesso = await manager.createBackup('data/backups');

      expect(sucesso, isTrue);
      expect(Directory('data/backups').existsSync(), isTrue);

      // Limpa arquivos criados
      File('data/clientes.json').deleteSync();
      File('data/produtos.json').deleteSync();
    });

    test('Deve lidar com backup sem arquivos existentes', () async {
      final sucesso = await manager.createBackup('data/backups');

      // Deve retornar true mesmo sem arquivos para backup
      expect(sucesso, isTrue);
    });
  });

  group('ConfiguracaoManager - Limpeza de Dados', () {
    test('Deve limpar logs antigos baseado na configuração', () async {
      // Cria arquivo de logs de teste
      Directory('data').createSync(recursive: true);
      final logsAntigos = [
        {
          'id': 1,
          'data_hora': DateTime.now()
              .subtract(const Duration(days: 100))
              .toIso8601String(),
          'descricao': 'Log antigo',
        },
        {
          'id': 2,
          'data_hora': DateTime.now()
              .subtract(const Duration(days: 10))
              .toIso8601String(),
          'descricao': 'Log recente',
        },
      ];

      final jsonContent = logsAntigos
          .map(
            (l) =>
                '{"id":${l['id']},"data_hora":"${l['data_hora']}","descricao":"${l['descricao']}"}',
          )
          .join(',');
      File('data/logs_atividade.json').writeAsStringSync('[$jsonContent]');

      final sucesso = await manager.clearOldLogs();

      expect(sucesso, isTrue);

      // Limpa arquivo criado
      File('data/logs_atividade.json').deleteSync();
    });

    test('Deve limpar todos os dados do sistema', () async {
      // Cria arquivos de dados
      Directory('data').createSync(recursive: true);
      File('data/clientes.json').writeAsStringSync('[{"id":1}]');
      File('data/produtos.json').writeAsStringSync('[{"id":1}]');
      File('data/usuarios.json').writeAsStringSync('[{"id":1}]');

      final sucesso = await manager.clearAllData();

      expect(sucesso, isTrue);

      // Verifica que os arquivos foram limpos
      expect(File('data/clientes.json').readAsStringSync(), equals('[]'));
      expect(File('data/produtos.json').readAsStringSync(), equals('[]'));
      expect(File('data/usuarios.json').readAsStringSync(), equals('[]'));

      // Limpa arquivos criados
      File('data/clientes.json').deleteSync();
      File('data/produtos.json').deleteSync();
      File('data/usuarios.json').deleteSync();
    });
  });

  group('ConfiguracaoManager - Validações de Dados', () {
    test('Deve aceitar valores válidos de frequência de backup', () async {
      final frequencias = ['diario', 'semanal', 'mensal'];

      for (final freq in frequencias) {
        final currentConfig = await manager.loadConfiguration();
        final config = currentConfig.copyWith(frequenciaBackup: freq);
        await manager.updateAppSettings(config);
        final updatedConfig = await manager.loadConfiguration();
        expect(updatedConfig.frequenciaBackup, equals(freq));
      }
    });

    test('Deve aceitar limites de estoque baixo válidos', () async {
      final limites = [1, 10, 25, 50];
      final currentConfig = await manager.loadConfiguration();
      for (final limite in limites) {
        final config = currentConfig.copyWith(limiteEstoqueBaixo: limite);
        await manager.updateAppSettings(config);
        final updatedConfig = await manager.loadConfiguration();
        expect(updatedConfig.limiteEstoqueBaixo, equals(limite));
      }
    });

    test('Deve aceitar tempo de bloqueio válido', () async {
      final tempos = [1, 5, 15, 30, 60];

      for (final tempo in tempos) {
        final currentConfig = await manager.loadConfiguration();
        final config = currentConfig.copyWith(tempoBloqueioMinutos: tempo);
        await manager.updateAppSettings(config);
        final updatedConfig = await manager.loadConfiguration();
        expect(updatedConfig.tempoBloqueioMinutos, equals(tempo));
      }
    });
  });

  group('ConfiguracaoManager - Serialização JSON', () {
    test(
      'Deve serializar e desserializar configurações corretamente',
      () async {
        final configOriginal = AppSettings(
          notificacoesAtivadas: false,
          notificarVendas: false,
          notificarEstoqueBaixo: true,
          limiteEstoqueBaixo: 20,
          temaEscuro: true,
          corPrimaria: EnumColorAppThemeSettings.verde,
          backupAutomatico: true,
          frequenciaBackup: 'diario',
          localBackup: 'custom/path',
          limpezaAutomatica: true,
          diasManterLogs: 60,
          exigirSenha: true,
          tempoBloqueioMinutos: 30,
          permitirMultiplosUsuarios: true,
        );

        await manager.updateAppSettings(configOriginal);

        // Cria novo manager para verificar serialização
        final manager2 = ConfigurationRepository(
          logRepository: LogRepository(logDao: systemDatabase.logDao),
          settingsService: SettingsService.injection(),
        );
        final configuracao = await manager2.loadConfiguration();
        expect(
          configuracao.notificacoesAtivadas,
          equals(configOriginal.notificacoesAtivadas),
        );
        expect(configuracao.temaEscuro, equals(configOriginal.temaEscuro));
        expect(configuracao.corPrimaria, equals(configOriginal.corPrimaria));
        expect(
          configuracao.backupAutomatico,
          equals(configOriginal.backupAutomatico),
        );
      },
    );
  });
}
