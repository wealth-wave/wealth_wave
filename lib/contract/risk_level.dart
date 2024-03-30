enum RiskLevel {
  veryLow,
  low,
  medium,
  high,
  veryHigh,
}

extension RiskLevelExtension on RiskLevel {
  int get intValue {
    switch (this) {
      case RiskLevel.veryLow:
        return 1;
      case RiskLevel.low:
        return 2;
      case RiskLevel.medium:
        return 3;
      case RiskLevel.high:
        return 4;
      case RiskLevel.veryHigh:
        return 5;
    }
  }
}