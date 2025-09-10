Duration getDelayUntilTime(int hour, int minute) {
  final now = DateTime.now();
  final todayTarget = DateTime(now.year, now.month, now.day, hour, minute);
  final nextRun = todayTarget.isAfter(now)
      ? todayTarget
      : todayTarget.add(const Duration(days: 1));

  return nextRun.difference(now);
}
