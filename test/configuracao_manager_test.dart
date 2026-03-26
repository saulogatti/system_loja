import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/cache/cache_manager.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/domain/repository/configuration_repository.dart';
import 'package:system_loja/domain/repository/system/log_repository.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ConfigurationRepository manager;
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults();
  late SystemDatabase systemDatabase;
  setUpAll(() {
    systemDatabase = SystemDatabase(executor: NativeDatabase.memory());
    PathProviderPlatform.instance = FakePathProviderPlatform();
    manager = ConfigurationRepository(
      logRepository: LogRepository(logDao: systemDatabase.logDao),
      settingsService: SettingsService.injection(),
      cache: CacheManager(),
    );
  });

  tearDownAll(() {
    manager.clearAllData();
    manager.resetToDefaults();
    manager.createBackup('data/backups');
    manager.clearOldLogs();
    manager.updateAppSettings(AppSettings.createDefaultSettings());
  });

  group('ConfiguracaoManager - Operações Básicas', () {
    test('Deve carregar configurações padrão na primeira execução', () async {
      await manager.resetToDefaults();
      final config = await _obterSucesso(manager.loadConfiguration());

      expect(config.notificacoesAtivadas, isTrue);
      expect(config.temaEscuro, isFalse);
      expect(config.limiteEstoqueBaixo, equals(10));
    });

    test('Deve atualizar configurações com sucesso', () async {
      final currentConfig = await _obterSucesso(manager.loadConfiguration());
      final novaConfig = currentConfig.copyWith(
        temaEscuro: true,
        notificarVendas: false,
      );

      await _executarSucesso(manager.updateAppSettings(novaConfig));

      final updatedConfig = await _obterSucesso(manager.loadConfiguration());

      expect(updatedConfig.temaEscuro, isTrue);

      expect(updatedConfig.notificarVendas, isFalse);
    });

    test('Deve persistir configurações após salvar', () async {
      final currentConfig = await _obterSucesso(manager.loadConfiguration());
      final novaConfig = currentConfig.copyWith(
        limiteEstoqueBaixo: 25,
        frequenciaBackup: 'mensal',
      );

      await _executarSucesso(manager.updateAppSettings(novaConfig));

      final manager2 = ConfigurationRepository(
        logRepository: LogRepository(logDao: systemDatabase.logDao),
        settingsService: SettingsService.injection(),
        cache: CacheManager(),
      );

      final updatedConfig2 = await _obterSucesso(manager2.loadConfiguration());

      expect(updatedConfig2.limiteEstoqueBaixo, equals(25));
      expect(updatedConfig2.frequenciaBackup, equals('mensal'));
    });

    test('Deve restaurar configurações padrão', () async {
      // Primeiro altera as configurações
      final currentConfig = await _obterSucesso(manager.loadConfiguration());
      final novaConfig = currentConfig.copyWith(
        temaEscuro: true,
        limiteEstoqueBaixo: 50,
      );
      await _executarSucesso(manager.updateAppSettings(novaConfig));

      // Depois restaura padrão
      await _executarSucesso(manager.resetToDefaults());

      final restoredConfig = await _obterSucesso(manager.loadConfiguration());

      expect(restoredConfig.temaEscuro, isFalse);
      expect(restoredConfig.limiteEstoqueBaixo, equals(10));
    });
  });

  group('ConfiguracaoManager - Backup de Dados', () {
    test('Deve criar estrutura de diretório para backup', () async {
      Directory('data').createSync(recursive: true);
      File('data/clientes.json').writeAsStringSync('[]');
      File('data/produtos.json').writeAsStringSync('[]');

      final resultado = await manager.createBackup('data/backups');

      expect(resultado.isSuccessful, isTrue);
      expect(Directory('data/backups').existsSync(), isTrue);

      File('data/clientes.json').deleteSync();
      File('data/produtos.json').deleteSync();
    });

    test('Deve lidar com backup sem arquivos existentes', () async {
      final resultado = await manager.createBackup('data/backups');

      // Deve retornar sucesso mesmo sem arquivos para backup
      expect(resultado.isSuccessful, isTrue);
    });
  });

  group('ConfiguracaoManager - Limpeza de Dados', () {
    test('Deve limpar logs antigos baseado na configuração', () async {
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

      final resultado = await manager.clearOldLogs();

      expect(resultado.isSuccessful, isTrue);

      File('data/logs_atividade.json').deleteSync();
    });
  });

  group('ConfiguracaoManager - Validações de Dados', () {
    test('Deve aceitar valores válidos de frequência de backup', () async {
      final frequencias = ['diario', 'semanal', 'mensal'];

      for (final freq in frequencias) {
        final currentConfig = await _obterSucesso(manager.loadConfiguration());
        final config = currentConfig.copyWith(frequenciaBackup: freq);
        await _executarSucesso(manager.updateAppSettings(config));
        final updatedConfig = await _obterSucesso(manager.loadConfiguration());
        expect(updatedConfig.frequenciaBackup, equals(freq));
      }
    });

    test('Deve aceitar limites de estoque baixo válidos', () async {
      final limites = [1, 10, 25, 50];
      final currentConfig = await _obterSucesso(manager.loadConfiguration());
      for (final limite in limites) {
        final config = currentConfig.copyWith(limiteEstoqueBaixo: limite);
        await _executarSucesso(manager.updateAppSettings(config));
        final updatedConfig = await _obterSucesso(manager.loadConfiguration());
        expect(updatedConfig.limiteEstoqueBaixo, equals(limite));
      }
    });

    test('Deve aceitar tempo de bloqueio válido', () async {
      final tempos = [1, 5, 15, 30, 60];

      for (final tempo in tempos) {
        final currentConfig = await _obterSucesso(manager.loadConfiguration());
        final config = currentConfig.copyWith(tempoBloqueioMinutos: tempo);
        await _executarSucesso(manager.updateAppSettings(config));
        final updatedConfig = await _obterSucesso(manager.loadConfiguration());
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

        await _executarSucesso(manager.updateAppSettings(configOriginal));

        final manager2 = ConfigurationRepository(
          logRepository: LogRepository(logDao: systemDatabase.logDao),
          settingsService: SettingsService.injection(),
          cache: CacheManager(),
        );
        final configuracao = await _obterSucesso(manager2.loadConfiguration());
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

Future<void> _executarSucesso(
  Future<ResultStatus<AppSettings, String>> future,
) async {
  final r = await future;
  expect(r.isSuccessful, isTrue, reason: r.hasError ? r.asError : null);
}

Future<AppSettings> _obterSucesso(
  Future<ResultStatus<AppSettings, String>> future,
) async {
  final r = await future;
  expect(r.isSuccessful, isTrue, reason: r.hasError ? r.asError : null);
  return r.asSuccess;
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/tmp';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return '/tmp';
  }

  @override
  Future<String?> getLibraryPath() async {
    return '/tmp';
  }

  @override
  Future<String?> getTemporaryPath() async {
    return '/tmp';
  }
}
