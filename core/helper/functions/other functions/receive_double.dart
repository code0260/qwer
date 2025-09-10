import 'package:almonazim/core/extension/string_extensions.dart';

double? receiveDouble(value) {
  return value is String? ? (value)?.toDouble() : (value as num?)?.toDouble();
}
