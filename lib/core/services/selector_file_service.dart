import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/converter/system_configuration_codec.dart';

class SelectorFileService {
  SelectorFileService();

  Future<String?> getSystemConfiguration() async {
    const acceptedTypes = <XTypeGroup>[
      XTypeGroup(label: 'json', extensions: ['json']),
    ];
    final file = await openFile(acceptedTypeGroups: acceptedTypes);

    if (file == null) {
      return null;
    }

    final content = await file.readAsString();
    return content;
  }

  Future<void> saveSystemConfiguration(
    SystemConfiguration systemConfiguration,
  ) async {
    const acceptedTypes = <XTypeGroup>[
      XTypeGroup(label: 'json', extensions: ['json']),
    ];
    final location = await getSaveLocation(
      suggestedName: 'system_configuration.json',
      acceptedTypeGroups: acceptedTypes,
    );

    if (location == null) {
      return;
    }

    final file = File(location.path);
    await file.writeAsString(
      jsonEncode(SystemConfigurationCodec.toJson(systemConfiguration)),
      flush: true,
    );
  }
}
