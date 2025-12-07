import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const SystemLojaApp());
}

class SystemLojaApp extends StatelessWidget {
  const SystemLojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gerenciamento de Loja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: kDebugMode,
    );
  }
}
