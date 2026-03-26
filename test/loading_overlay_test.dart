import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/widgets/loading_overlay.dart';

/// Testes do widget LoadingOverlay
///
/// Valida que o overlay de loading é exibido corretamente com
/// indicador de progresso e mensagem opcional.
void main() {
  group('LoadingOverlay Widget Tests', () {
    testWidgets('deve exibir CircularProgressIndicator', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LoadingOverlay())));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve exibir mensagem quando fornecida', (WidgetTester tester) async {
      // Arrange
      const testMessage = 'Carregando dados...';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingOverlay(message: testMessage)),
        ),
      );

      // Assert
      expect(find.text(testMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('não deve exibir mensagem quando não fornecida', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LoadingOverlay())));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Não deve haver nenhum Text widget visível além dos do Scaffold
      expect(find.descendant(of: find.byType(LoadingOverlay), matching: find.byType(Text)), findsNothing);
    });

    testWidgets('deve bloquear interações com ModalBarrier', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Test Button')),
                const LoadingOverlay(),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();
      expect(find.byType(ModalBarrier), findsWidgets);
    });
  });
}
