dynamic toLocalTime(String? datetime) {
  if (datetime == null) {
    return;
  } else {
    if (!datetime.contains("Z")) {
      datetime = '${DateTime.parse(datetime).toString()}Z';
    }
    return DateTime.parse(datetime).toLocal().toString();
  }
}
