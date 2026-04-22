import 'package:flutter/material.dart';

/// Um widget reutilizável para exibir estados vazios com semântica adequada.
class EmptyWidget extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData icon;
  final Widget? action;
  final String? semanticLabel;

  const EmptyWidget({
    required this.message,
    this.subMessage,
    this.icon = Icons.inbox_outlined,
    this.action,
    this.semanticLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label:
                  semanticLabel ??
                  (subMessage != null ? '$message. $subMessage' : message),
              container: true,
              excludeSemantics: true,
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withAlpha(128),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (subMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      subMessage!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
