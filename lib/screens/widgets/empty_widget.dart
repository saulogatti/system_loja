import 'package:flutter/material.dart';

/// A reusable widget to display empty states consistently across the application.
///
/// It provides a standardized visual representation for empty lists or missing data,
/// including an icon, a primary message, and an optional subtitle.
/// It wraps its content in a [Semantics] widget with `excludeSemantics: true`
/// to ensure screen readers read the state as a single unified label, improving accessibility.
class EmptyWidget extends StatelessWidget {
  /// The primary message to display.
  final String message;

  /// The icon to display above the message. Defaults to [Icons.inbox_outlined].
  final IconData icon;

  /// An optional subtitle providing more context or instructions.
  final String? subtitle;

  const EmptyWidget({
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Semantics(
          label: subtitle != null ? '$message. $subtitle' : message,
          excludeSemantics: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withAlpha(128),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
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
