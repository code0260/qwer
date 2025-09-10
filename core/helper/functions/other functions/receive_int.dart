import 'package:almonazim/core/extension/string_extensions.dart';

int? receiveInt(value) {
  return value is String? ? (value)?.toInt() : (value as num?)?.toInt();
}
