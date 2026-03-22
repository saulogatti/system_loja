import 'package:flutter/material.dart';

/// Widget de overlay de loading que bloqueia interações com a tela.
///
/// Exibe um [CircularProgressIndicator] centralizado com uma mensagem opcional.
/// Utiliza [ModalBarrier] para bloquear todas as interações do usuário
/// durante o carregamento.
///
/// Exemplo de uso:
/// ```dart
/// Stack(
///   children: [
///     // Conteúdo principal da tela
///     YourScreenContent(),
///
///     // Overlay de loading
///     if (isLoading)
///       const LoadingOverlay(message: 'Carregando dados...'),
///   ],
/// )
/// ```
class LoadingOverlay extends StatelessWidget {
  /// Mensagem opcional a ser exibida abaixo do indicador de progresso.
  final String? message;

  /// Cor de fundo do overlay. Padrão: preto com 50% de opacidade.
  final Color? backgroundColor;

  /// Cor do indicador de progresso. Se não especificado, usa a cor primária do tema.
  final Color? progressIndicatorColor;

  const LoadingOverlay({
    super.key,
    this.message,
    this.backgroundColor,
    this.progressIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        progressIndicatorColor ?? Theme.of(context).colorScheme.primary;
    final colorAnimation = AlwaysStoppedAnimation<Color>(indicatorColor);

    return Stack(
      children: [
        // Modal barrier para bloquear interações
        ModalBarrier(
          dismissible: false,
          color: backgroundColor ?? Colors.black.withValues(alpha: 0.5),
        ),
        // Indicador de progresso centralizado
        Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(valueColor: colorAnimation),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
