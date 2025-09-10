String? toServerTime(String? datetime) {
  if (datetime == null) {
    return null;
  } else {
    return DateTime.parse(datetime).toUtc().toString();
  }
}
