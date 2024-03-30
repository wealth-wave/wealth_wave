enum Frequency {
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  halfYearly,
  yearly,
}

Duration getDuration(Frequency frequency) {
  switch (frequency) {
    case Frequency.daily:
      return const Duration(days: 1);
    case Frequency.weekly:
      return const Duration(days: 7);
    case Frequency.biweekly:
      return const Duration(days: 14);
    case Frequency.monthly:
      return const Duration(days: 30);
    case Frequency.quarterly:
      return const Duration(days: 91);
    case Frequency.halfYearly:
      return const Duration(days: 182);
    case Frequency.yearly:
      return const Duration(days: 365);
    default:
      throw Exception('Invalid frequency');
  }
}
