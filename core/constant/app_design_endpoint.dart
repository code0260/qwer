import 'package:flutter/material.dart';

class AppDesignEndpoint {
  AppDesignEndpoint._();
  static const double tablet = 800;
  static const double desktop = 1200;

  static bool isTablet(context) {
    return MediaQuery.sizeOf(context).width > tablet &&
        MediaQuery.sizeOf(context).width < desktop;
  }

  static bool isMobile(context) {
    return MediaQuery.sizeOf(context).width < tablet;
  }

  static bool isDesktop(context) {
    return MediaQuery.sizeOf(context).width > desktop;
  }
}
