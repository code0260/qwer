// Method to show the floating scanner widget
import 'package:almonazim/core/shared/buttons/floating_expandable_fab.dart';
import 'package:flutter/material.dart';

class FloatingOverlayIcons {
  FloatingOverlayIcons._();
  static OverlayEntry? overlayIcons;

  static void showFloatingOverlayIcons(
      {required BuildContext context, void Function(double)? onCalculated}) {
    if (overlayIcons == null || overlayIcons?.mounted == false) {
      overlayIcons = OverlayEntry(builder: (context) {
        return const FloatingExpandableFab();
      });
      Overlay.of(context).insert(overlayIcons!);
    }
  }

  // Method to remove the floating widget
  static void removeFloatingWidget() {
    overlayIcons?.remove();
  }
}
