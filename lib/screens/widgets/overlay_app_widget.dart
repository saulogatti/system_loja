import 'package:flutter/material.dart';

class OverlayApp {
  OverlayEntry? _overlayEntry;

  void createHighlightOverlay({
    required String label,
    required Color color,
    required BuildContext context,
    required Widget widget,
  }) {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    _overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return ColoredBox(
          color: color.withValues(alpha: 0.3),

          child: Column(
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(_overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
}
