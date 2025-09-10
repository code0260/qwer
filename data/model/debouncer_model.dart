import 'dart:async';

import 'package:flutter/material.dart';

// A debouncer class to delay function calls.
// This prevents excessive requests while the user is typing.
class DebouncerModel {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  DebouncerModel({required this.milliseconds});

  dynamic run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
