// Method to show the floating scanner widget
import 'package:almonazim/view/widget/scanner/floating_scanner.dart';
import 'package:flutter/material.dart';

OverlayEntry showFloatingScanner(
    {required BuildContext context,
    required OverlayEntry? overlayEntry,
    required void Function() onRemove,
    required void Function(String) onScan}) {
  if (overlayEntry == null) {
    overlayEntry = OverlayEntry(
      builder: (context) => FloatingScanner(
        entry: overlayEntry!,
        onRemove: () {
          onRemove.call();
          removeFloatingWidget(overlayEntry);
        },
        onScan: (barcode) {
          onScan.call(barcode);
        },
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }
  return overlayEntry;
}

// Method to remove the floating widget
void removeFloatingWidget(OverlayEntry? overlayEntry) {
  if (overlayEntry != null && overlayEntry.mounted) {
    overlayEntry.remove();
    overlayEntry = null;
  }
}
