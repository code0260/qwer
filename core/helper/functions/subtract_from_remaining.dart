double subtractFromRemaining(double currentCount, double currentCountConversion,
    double remainingCount, double remainingCountConversion) {
  double convertToFit = currentCountConversion / remainingCountConversion;
  double totalRemaining = remainingCount - (convertToFit * currentCount);
  return totalRemaining;
}
