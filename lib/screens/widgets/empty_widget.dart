import 'package:flutter/material.dart';

/// A reusable widget to display empty states consistently across the application.
///
/// Provides a semantic, accessible alternative to hardcoded text and icons.
class EmptyWidget extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData? icon;

  const EmptyWidget({
    required this.message,
    this.subMessage,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$message ${subMessage ?? ''}',
      excludeSemantics: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary.withAlpha(128),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                message,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: icon == null ? Colors.grey : null,
                ),
                textAlign: TextAlign.center,
              ),
              if (subMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  subMessage!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
