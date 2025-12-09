import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(const SystemLojaApp());
}

class SystemLojaApp extends StatelessWidget {
  const SystemLojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: SettingsService().primaryColorNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Sistema de Gerenciamento de Loja',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: value.color),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: kDebugMode,
        );
      },
    );
  }
}
